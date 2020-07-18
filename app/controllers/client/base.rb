class Client::Base < ApplicationController
  layout 'client/client'
  before_action :authenticate_client!

  protected

  # 他会員の閲覧制限
  def correct_client?(client_id)
    if current_client.id != client_id
      redirect_to request.referrer || root_path
    end
  end
end