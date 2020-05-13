require 'rails_helper'

describe 'POST /api/v1/transactions' do
  context 'when the correct parameters are passed' do
    it 'returns 200 (ok status)' do
      first_account = create(:account, number: 1234)
      second_account = create(:account, number: 5678)

      params = {
        source_account_id: first_account.number,
        destination_account_id: second_account.number,
        amount: 50000
      }

      post '/api/v1/transactions', params: params

      expect(response).to have_http_status(:ok)
    end
  end

  context 'when the incorrect parameters are passed' do
    it 'returns 422 (unprocessable entity)' do
      second_account = create(:account, number: 5678)

      params = {
        source_account_id: nil,
        destination_account_id: second_account.number,
        amount: 50000
      }

      post '/api/v1/transactions', params: params

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

        #source_account_id: SecureRandom.random_number(9999),
        #destination_account_id: SecureRandom.random_number(9999),
        #amount: 50000