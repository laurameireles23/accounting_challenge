module Api::V1
  class AccountsController < ApplicationController 
    def create
      
    end

    def show
      account = Account.find(params[:id])
      render json: {
        status: 'SUCCESS', 
        message:'Loaded account', 
        data:account
      },status: :ok
    end
  end
end
