require 'rails_helper'

RSpec.describe "Expert::Problems", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/expert/problems/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/expert/problems/show"
      expect(response).to have_http_status(:success)
    end
  end

end
