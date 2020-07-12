require 'rails_helper'

RSpec.describe "Client::Clients", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/client/clients/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/client/clients/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
