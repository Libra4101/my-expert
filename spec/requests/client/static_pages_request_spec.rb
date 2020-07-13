require 'rails_helper'

RSpec.describe "Client::StaticPages", type: :request do

  describe "GET /top" do
    it "returns http success" do
      get "/client/static_pages/top"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/client/static_pages/about"
      expect(response).to have_http_status(:success)
    end
  end

end
