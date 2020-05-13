# frozen_string_literal: true

require 'rails_helper'

describe Account do
  context 'new account' do
    describe 'when a new account is created' do
      it 'successfully' do
        account = create(:account)

        expect(account.number).to eq account.number
        expect(account.name).to eq account.name
        expect(account.balance).to eq account.balance
        expect(account.token).to eq account.token
      end
    end

    describe 'validates' do
      it 'is valid with valid attributes' do
        account = create(:account)

        expect(account).to be_valid
      end

      it 'is not valid without a name' do
        account = build(:account, name: nil)

        expect(account).to_not be_valid
      end

      it 'is not valid without a number' do
        account = build(:account, number: nil)

        expect(account).to_not be_valid
      end

      it 'is not valid without a balance' do
        account = build(:account, balance: nil)

        expect(account).to_not be_valid
      end

      it 'is not valid without a token' do
        account = build(:account, token: nil)

        expect(account).to_not be_valid
      end
    end
  end
end
