require 'rails_helper'

RSpec.describe "Admin::Clients", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admin/clients/index"
      expect(response).to have_http_status(:success)
    end
  end

end
