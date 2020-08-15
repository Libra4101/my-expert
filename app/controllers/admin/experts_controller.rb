class Admin::ExpertsController < Admin::Base
  before_action :set_expert, only: %i[show edit update withdraw]

  def index
    @experts = Expert.page(params[:page]).per(10)
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
