class Client::Base < ApplicationController
  layout 'client/client'
  before_action :authenticate_client!
end