require 'rails_helper'

describe 'POST /api/v1/accounts' do
  context 'when the correct parameters are passed' do
    it 'returns 200 (ok status)' do
      params = {
        number: 1234,
        name: 'John Due',
        balance: 150000
      }

      post '/api/v1/accounts', params: params

      expect(response).to have_http_status(:ok)
    end

    it 'returns 200 (ok status) when generates number account' do
      params = {
        number: nil,
        name: 'John Due',
        balance: 150000
      }

      post '/api/v1/accounts', params: params

      expect(response).to have_http_status(:ok)
    end

    it 'returns 422 (unprocessable entity)' do
      params = {
        number: 1234,
        name: nil,
        balance: 150000
      }

      post '/api/v1/accounts', params: params

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end