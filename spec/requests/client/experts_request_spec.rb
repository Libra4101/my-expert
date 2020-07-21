require 'rails_helper'

RSpec.describe "Client::Experts", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/client/experts/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/client/experts/show"
      expect(response).to have_http_status(:success)
    end
  end

end
