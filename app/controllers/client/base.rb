class Client::Base < ApplicationController
  layout 'client/client'
  before_action :authenticate_client!

  protected

  # 他会員の閲覧制限
  def correct_client?(client_id)
    if current_client.id != client_id
      redirect_back(fallback_location: root_path)
    end
  end

  # ゲストユーザーチェック
  def check_guest_client
    if current_client.email == 'guest@example.com'
      flash[:danger] = t('guest.check')
      redirect_to root_path
    end
  end
end