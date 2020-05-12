module Api::V1
  class AccountsController < ApplicationController 
    def create
      begin
        account = Account.new(account_params)
        account.token = generate_token
        account.number = generate_id if account_params[:number].nil?
        account.save!

        render json: account, status: :ok
      rescue ActiveRecord::RecordInvalid
        render json: {
          errors: account.errors,
          message: "Falha ao criar a conta. Tente novamente!" 
        },
        status: :unprocessable_entity
      rescue StandardError
        render json: {
          message: "Falha ao criar a conta. Tente novamente!"
        },
        status: :internal_server_error
      end
    end
  end
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