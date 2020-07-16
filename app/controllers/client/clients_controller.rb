class Client::ClientsController < Client::Base
  before_action :set_client, only: [:edit, :show]
  before_action :set_search_params, only: :show

  def show
    @experts = current_client.experts.page(params[:experts_page]).per(8)
    @problems = problem_list.page(params[:problems_page]).per(10)
    @consultations = consultations_list.page(params[:consultations_page]).per(10)
  end
  
  def update
    @client = Client.find(current_client.id)
      if @client.update(client_params)
        flash[:success] = "client was successfully updated"
        redirect_to clients_url
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
  end

  private

  # 会員情報を設定
  def set_client
    @client = current_client
  end

  # ストロングパラメータ
  def client_params
    params.require(:client).permit(
      :name,
      :name_kana,
      :email,
      :gender,
      :age,
      :address,
      :postcode,
      :phone_number,
      :avater_image
    )
  end

  # 検索パラメータを設定
  def set_search_params
    @search_params = {
      nav_type: params[:nav_type],
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
        problems.left_joins(:comments).group(:id).order('count(comments.id) DESC')
      when 'new_coment_sort' 
        problems.left_joins(:comments).group(:id).order('max(comments.created_at) DESC')
      else
        problems
    end
  end

  # 検索条件に合致する相談リスト
  def consultations_list
    # キーワード検索結果
    consultations = Consultation.search(@search_params[:keyword_consultation]).where(client_id: current_client.id)
    # 予約状態設定
    status = @search_params[:sort_consultation]
    if status.blank? || status == 'all'
      return consultations
    else
      consultations.where(reservation_status: status)
    end
  end
end
