require 'rails_helper'

RSpec.describe 'Selects', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/selects/index'
      expect(response).to have_http_status(:success)
    end
  end
end
