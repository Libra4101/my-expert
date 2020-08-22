class Expert::ConsultationsController < Expert::Base
  before_action :set_expert
  before_action :set_search_params, only: :index

  def index
    @consultations = consultations_list.includes(:event).includes(:client).page(params[:page]).per(10)
  end

  def show
    @consultation = @expert.consultations.find_by_id(params[:id])
  end

  def update
    @consultation = @expert.consultations.find_by_id(params[:id])
    if @consultation.update(consultation_param)
      flash[:success] = t('success.update_consultation_status')
      redirect_to expert_consultation_url(@consultation)
    else
      flash.now[:error] = t('error.validate_error')
      render :show
    end
  end
  

  private
  def set_expert
    @expert = Expert.find_by_id(current_expert.id)
  end

  # ストラングパラメーター
  def consultation_param
    params.require(:consultation)
      .permit(:reservation_status)
      .merge(expert_id: current_expert.id)
  end

  # 検索パラメータを設定
  def set_search_params
    @search_params = {
      keyword_problem: params[:search_problem_keyword],
      sort_problem: params[:search_problem_sort],
      keyword_consultation: params[:search_consultation_keyword],
      sort_consultation: params[:search_consultation_sort]
    }
  end

  # 検索条件に合致する相談リスト
  def consultations_list
    # キーワード検索結果
    consultations = Consultation.search(@search_params[:keyword_consultation]).where(expert_id: current_expert.id)
    # 予約状態設定
    status = @search_params[:sort_consultation]
    if status.blank? || status == 'all'
      return consultations
    else
      consultations.where(reservation_status: status)
    end
  end
end
