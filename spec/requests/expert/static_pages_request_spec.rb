require 'rails_helper'

RSpec.describe "Expert::StaticPages", type: :request do

  describe "GET /top" do
    it "returns http success" do
      get "/expert/static_pages/top"
      expect(response).to have_http_status(:success)
    end
  end

end
