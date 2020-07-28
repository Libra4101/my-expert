require 'rails_helper'

RSpec.describe "Expert::Experts", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/expert/experts/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/expert/experts/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
