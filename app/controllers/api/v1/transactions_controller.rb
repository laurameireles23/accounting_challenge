# frozen_string_literal: true

module Api::V1
  class TransactionsController < ApplicationController
    before_action :authenticate

    def create
      transaction = Transaction.create!(transaction_params)
      source_account = Account.find_by!(number: transaction[:source_account_id])
      destination_account = Account.find_by!(
        number: transaction[:destination_account_id]
      )
      amount = transaction.amount

      if source_account.balance < amount
        message = 'O saldo não é suficiente.'
        status_render = :bad_request
      else
        source(source_account, amount)
        destination(destination_account, amount)
        transaction.update!(not_approved: false)

        message = 'Transação realizada com sucesso!'
        status_render = :ok
      end

      render_json(message, status_render)
    rescue ActiveRecord::RecordInvalid
      render json: {
        message: 'A conta informada não existe.'
      }, status: :unprocessable_entity
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
      authenticate_with_http_token do |token, _option|
        Account.find_by!(token: token).present?
      end
    end

    def render_json(message, status_render)
      render json: {
        message: message
      }, status: status_render
    end
  end
end
