class Expert::ProblemsController < Expert::Base
  before_action :set_search_params, only: :index

  def index
    @problems = problem_list.includes(:client).page(params[:page]).per(10)
  end

  def show
    @problem = Problem.find(params[:id])
    @comments = @problem.comments.includes(:expert).includes(:client)
    @comment = Comment.new
  end

  private
  # 検索パラメータを設定
  def set_search_params
    @search_params = {
      keyword_problem: params[:search_problem_keyword],
      sort_problem: params[:search_problem_sort],
      keyword_consultation: params[:search_consultation_keyword],
      sort_consultation: params[:search_consultation_sort]
    }
  end

  # 検索条件に合致する投稿リスト
  def problem_list
    # キーワード検索結果
    problems = Problem.search(@search_params[:keyword_problem]).where(client_id: current_client.id)
    # ソート条件設定
    case @search_params[:sort_problem]
      when 'new_sort'
        problems.order('created_at DESC')
      when 'update_sort'
        problems.order('updated_at DESC')
      when 'many_coment_sort'
        problems.joins(:comments).group(:id).order('count(comments.id) DESC')
      when 'new_coment_sort' 
        problems.joins(:comments).group(:id).order('max(comments.updated_at) DESC')
      else
        problems
    end
  end
end
