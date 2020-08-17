class Admin::ExpertsController < Admin::Base
  before_action :set_expert, only: %i[show edit update withdraw]

  def index
    @experts = Expert.page(params[:page]).per(4)
  end

  def new
    if session[:expert].present?
      @expert = Expert.new(session[:expert])
    else
      @expert = Expert.new
    end
  end

  def create
    @expert = Expert.new(expert_param)
    if @expert.valid?(:new_save)
      session[:expert] = expert_param
      redirect_to offices_new_admin_experts_path
    else
      flash.now[:error] = t('error.validate_error')
      render :new
    end
  end

  def show
    gon.latitude = @expert.office.latitude
    gon.longitude = @expert.office.longitude
  end

  def edit
  end

  def update
    if @expert.update(expert_param)
      flash[:success] = t('success.update_profile')
      redirect_to admin_expert_url(@expert)
    else
      flash.now[:error] = t('error.validate_error')
      render :edit
    end
  end

  def withdraw
    if @expert.update(withdraw_status: (!@expert.withdraw_status))
      flash[:success] = ("#{@expert.withdraw_status ? "復元" : "退会"}にステータス更新しました。")
      redirect_to admin_experts_url
    else
      flash[:error] = t('error.withdraw')
      redirect_to admin_experts_url
    end
  end
  
  private

  def set_expert
    @expert = Expert.find(params[:id])
  end

  # ストラングパラメーター
  def expert_param
    params.require(:expert)
    .permit(
      :avater_image,
      :email,
      :password,
      :password_confirmation,
      :name,
      :name_kana,
      :gender,
      :age,
      :phone_number,
      :job_id,
      :public_status,
      :introduction
    )
  end
end
