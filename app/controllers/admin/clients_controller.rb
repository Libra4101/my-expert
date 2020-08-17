class Admin::ClientsController < Admin::Base
  before_action :set_client, only: %i[show withdraw]

  def index
    @clients = Client.page(params[:page]).per(4)
  end

  def show
  end

  def withdraw
    if @client.update(withdraw_status: (!@client.withdraw_status))
      flash[:success] = ("#{@client.withdraw_status ? "復元" : "退会"}にステータス更新しました。")
      redirect_to admin_clients_url
    else
      flash[:error] = t('error.withdraw')
      redirect_to admin_clients_url
    end
  end
  
  private

  def set_client
    @client = Client.find(params[:id])
  end
end
