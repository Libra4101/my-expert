class Expert::ProblemsController < Expert::Base
  before_action :set_search_params, only: :index

  def index
    @problems = problem_list.page(params[:page]).per(10)
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
    problems = Problem.search(@search_params[:keyword_problem]).includes(:client)
    # ソート条件設定
    sort_hash = {
      new_sort: "created_at DESC",
      update_sort: "updated_at DESC",
      many_coment_sort: "count(comments.id) DESC",
      new_coment_sort: "max(comments.updated_at) DESC"
    }
    # ソート条件に合致するテーブルを結合
    if @search_params[:sort_problem] == 'many_coment_sort' or @search_params[:sort_problem] == 'new_coment_sort'
      problems.joins(:comments).group(:id).order(sort_hash[@search_params[:sort_problem]&.to_sym])
    else
      problems.order(sort_hash[@search_params[:sort_problem]&.to_sym])
    end
  end
end
