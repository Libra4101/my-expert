class Client::ConsultationsController < Client::Base
  before_action :set_expert_info, only: %i[new events]
  before_action :check_guest_client, only: :create

  def new
    @consultation = Consultation.new
    gon.json_path = "events.json?expert_id=#{@expert.id}"
  end

  def create
    # 相談予約情報を設定
    @consultation = Consultation.new(set_consultation_param)

    # 相談予約情報のバリデーションチェック
    if @consultation.valid?(:new_save)

      begin
        # 相談予約情報を登録
        @event = create_event_form_param
        @event.save!
        @consultation.event = @event
        @consultation.save!

        # 相談予約完了メッセージ
        flash[:success] = t('success.create_consultation')
        # 相談予約完了メールを送信
        Client::ReservationConfirmationMailer.send_confirm_reservation(@consultation).deliver_now
        # マイページ画面へ遷移
        redirect_to clients_url(nav_type: 'consultations')  

      rescue => e
        # 予期せぬエラー時
        logger.error e
        logger.error e.backtrace.join("\n")
        Bugsnag.notify e
        flash[:error] = t('error.unexpected')
        redirect_to root_url
      end
    else
      # バリデーションエラー時
      @expert = Expert.find_by_id(params[:consultation][:expert_id])
      gon.json_path = "consultations/events.json?expert_id=#{@expert.id}"
      flash.now[:error] = t('error.validate_error')
      render :new
    end
  end
  
  def show
    @consultation = Consultation.find_by_id(params[:id])
  end

  def events
    consul_list = @expert.consultations.includes(:event)
    @events = consul_list.map{|consul| consul.event}
  end

  private

  # ストラングパラメーター
  def set_consultation_param
    params.require(:consultation)
      .permit(:content, :expert_id, :event_time)
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
    event_time = Time.zone.parse(params[:consultation]["event_time"])
    if event_time.blank?
      return Event.new
    else
      Event.new(
        title: "予約済み",
        start_event_time: event_time,
        end_event_time: (event_time + 1.hours)
      )
    end
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
