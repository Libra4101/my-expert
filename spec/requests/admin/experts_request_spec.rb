require 'rails_helper'

RSpec.describe "Admin::Experts", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admin/experts/index"
      expect(response).to have_http_status(:success)
    end
  end

end