require 'rails_helper'

RSpec.describe "Admin::Offices", type: :request do

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/offices/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
