class Admin::Base < ApplicationController
  layout 'admin/admin'
  before_action :authenticate_admin!
end