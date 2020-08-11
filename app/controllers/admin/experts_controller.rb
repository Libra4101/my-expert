class Admin::ExpertsController < Admin::Base
  before_action :set_expert, only: %i[show withdraw]

  def index
    @experts = Expert.page(params[:page]).per(10)
  end

  def show
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
end
