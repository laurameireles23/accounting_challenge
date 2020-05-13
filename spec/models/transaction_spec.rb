require 'rails_helper'

describe Transaction do
  context 'new transaction' do
    describe 'validates' do
      it 'is valid with valid attributes' do
        transaction = create(:transaction)

        expect(transaction).to be_valid
      end
    
      it 'is not valid without a source_account_id' do
        transaction = build(:transaction, source_account_id: nil)

        expect(transaction).to_not be_valid
      end

      it 'is not valid without a destination_account_id' do
        transaction = build(:transaction, destination_account_id: nil)

        expect(transaction).to_not be_valid
      end

      it 'is not valid without a amount' do
        transaction = build(:transaction, amount: nil)

        expect(transaction).to_not be_valid
      end
    end
  end
end