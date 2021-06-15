require 'rails_helper'

RSpec.describe "Permits", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/permits/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/permits/create"
      expect(response).to have_http_status(:success)
    end
  end

end
