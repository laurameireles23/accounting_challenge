# frozen_string_literal: true

module Api::V1
  class AccountsController < ApplicationController
    before_action :authenticate, except: %i[create]

    def create
      account = Account.new(account_params)
      account.token = generate_token
      account.number = generate_id if account_params[:number].nil?
      account.save!

      render json: {
        data: account
      }, status: :ok
    rescue ActiveRecord::RecordInvalid
      render json: {
        errors: account.errors,
        message: 'Falha ao criar a conta. Tente novamente!'
      }, status: :unprocessable_entity
    rescue StandardError
      render json: {
        message: 'Falha ao criar a conta. Tente novamente!'
      }, status: :internal_server_error
    end

    def show
      account = Account.find_by!(number: account_params[:number])
      balance = account.balance / 100

      render json: {
        message: "O saldo da conta #{account.number} é de R$#{balance}.",
        data: account
      }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        errors: e,
        message: 'A conta informada não existe.'
      }, status: :not_found
    end

    private

    def generate_token
      SecureRandom.hex(10)
    end

    def generate_id
      SecureRandom.random_number(9999)
    end

    def account_params
      params.permit(:name, :number, :balance, :token)
    end

    def authenticate
      authenticate_with_http_token do |token, _options|
        Account.find_by!(token: token).present?
      end
    end
  end
end
