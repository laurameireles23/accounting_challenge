require 'rails_helper'

RSpec.describe Account do
  context 'new account' do
    describe 'when a new account is created' do
      it 'successfully' do
        account = Account.create(
          number: 123,
          name: 'John Due',
          balance: 150000,
          token: 'thisisavalidtoken123'
        )

        account.save
        account.reload

        expect(account.number).to eq 123
        expect(account.name).to eq 'John Due'
        expect(account.balance).to eq 150000
        expect(account.token).to eq 'thisisavalidtoken123'
      end
    end
  end
end