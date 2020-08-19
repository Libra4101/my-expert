class Client::ConsultationsController < Client::Base
  before_action :set_expert_info, only: new
  before_action :check_guest_client, only: :create

  def new
    if @expert.present?
      @consultation = Consultation.new
      consul_list =  @expert.consultations.includes(:event)
      @events = consul_list.map{|consul| consul.event}
    else
      flash[:error] = t('error.unexpected')
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @consultation = Consultation.new(set_consultation_param)
    @event = create_event_form_param
    @consultation.event = @event

    if @consultation.save && @event.save
      flash[:success] = t('success.create_consultation')
      Client::ReservationConfirmationMailer.send_confirm_reservation(@consultation).deliver_now
      redirect_to clients_url(nav_type: 'consultations')
    else
      @expert = Expert.find_by_id(params[:consultation][:expert_id])
      flash.now[:error] = t('error.validate_error')
      render :new
    end
  end
  
  def show
    @consultation = Consultation.find_by_id(params[:id])
  end

  private

  # ストラングパラメーター
  def set_consultation_param
    params.require(:consultation)
      .permit(:content, :expert_id)
      .merge(
            client_id: current_client.id,
            trouble_tag_id: get_trouble_tag_id
          )
  end

  # 相談カテゴリを取得
  def get_trouble_tag_id
    trouble_category = TroubleTag.find_by_id(params[:consultation][:trouble_tag_id].to_i)
    trouble_category.id if trouble_category
  end

  # イベント情報を設定
  def create_event_form_param
    event_time = Time.zone.local(
      params[:consultation]["start_event_time(1i)"].to_i,
      params[:consultation]["start_event_time(2i)"].to_i,
      params[:consultation]["start_event_time(3i)"].to_i,
      params[:consultation]["start_event_time(4i)"].to_i,
      params[:consultation]["start_event_time(5i)"].to_i
    ).to_datetime

    event = Event.new(
      title: "相談予約",
      start_event_time: event_time,
      end_event_time: (event_time + Rational(1, 24))
    )
  end

  def set_expert_info
    if params[:expert_id].present?
      @expert = Expert.find_by_id(params[:expert_id])
      session[:consul_expert] = @expert
    else
      session[:consul_expert].clear
    end
  end
  
end
