# frozen_string_literal: true

require 'rails_helper'

describe 'POST /api/v1/transactions' do
  context 'when the correct parameters are passed' do
    it 'returns 200 (ok status)', :aggregate_failures do
      first_account = create(:account, number: 1234)
      second_account = create(:account, number: 5678)

      params = {
        source_account_id: first_account.number,
        destination_account_id: second_account.number,
        amount: 50_000,
        not_approved: true
      }

      post '/api/v1/transactions',
           headers: { 'HTTP_AUTHORIZATION' => first_account.token },
           params: params

      expect(response).to have_http_status(:ok)
      transaction = Transaction.last

      expect(response).to have_http_status(:ok)
      expect(transaction.not_approved).to eq false
    end
  end

  context 'when the incorrect parameters are passed' do
    it 'returns 422 (unprocessable entity)' do
      second_account = create(:account, number: 5678)

      params = {
        source_account_id: nil,
        destination_account_id: second_account.number,
        amount: 50_000
      }

      post '/api/v1/transactions',
           headers: { 'HTTP_AUTHORIZATION' => second_account.token },
           params: params

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns 400 (bad request status)', :aggregate_failures do
      first_account = create(:account, number: 1234)
      second_account = create(:account, number: 5678)

      params = {
        source_account_id: first_account.number,
        destination_account_id: second_account.number,
        amount: 160_000,
        not_approved: true
      }

      post '/api/v1/transactions',
           headers: { 'HTTP_AUTHORIZATION' => first_account.token },
           params: params

      transaction = Transaction.last

      expect(response).to have_http_status(:bad_request)
      expect(transaction.not_approved).to eq true
    end
  end
end
