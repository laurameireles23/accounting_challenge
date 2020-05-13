module Api::V1
  class TransactionsController < ApplicationController
    def create
      begin
        transaction = Transaction.create!(transaction_params)

        render json: {
          data: transaction, 
        }, status: :ok
      rescue ActiveRecord::RecordInvalid
        render json: {
          message: "Falha ao criar a transação. Tente novamente!"
        }, status: :unprocessable_entity
      rescue StandardError
        render json: {
          message: "Falha ao criar a transação. Tente novamente!"
        }, status: :internal_server_error
      end
    end

    private

    def transaction_params
      params.permit(:source_account_id, :destination_account_id, :amount)
    end
  end
end
