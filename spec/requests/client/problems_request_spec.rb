require 'rails_helper'

RSpec.describe "Client::Problems", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/client/problems/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/client/problems/show"
      expect(response).to have_http_status(:success)
    end
  end

end
