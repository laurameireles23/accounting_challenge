module Api::V1
  class TransactionsController < ApplicationController
    before_action :authenticate

    def create
      begin
        transaction = Transaction.create!(transaction_params)
        source_account = Account.find_by!(number: transaction[:source_account_id])
        destination_account = Account.find_by!(number: transaction[:destination_account_id])
        amount = transaction.amount 
        
        if source_account.balance < amount
          message = 'O saldo não é suficiente.'
          status = :bad_request
        end

        source(source_account, amount)
        destination(destination_account, amount)
        transaction.update!(not_approved: false)

        message = 'Transação realizada com sucesso!'
        status = :ok
        render(message, status)
        
      rescue ActiveRecord::RecordInvalid
        render json: {
          message: "Falha ao criar a transação. Tente novamente!"
        }, status: :unprocessable_entity
      end
    end

    private

    def transaction_params
      params.permit(:source_account_id, :destination_account_id, :amount)
    end

    def source(source_account, amount)
      source_account.balance -= amount
      source_account.update!(balance: source_account.balance)
    end

    def destination(destination_account, amount)
      destination_account.balance += amount
      destination_account.update!(balance: destination_account.balance)
    end

    def authenticate
      authenticate_with_http_token do |token, option|
        Account.find_by!(token: token).present?
      end
    end

    def render(message, status)
      render json: {
        message: message
      }, status: status
    end
  end
end
