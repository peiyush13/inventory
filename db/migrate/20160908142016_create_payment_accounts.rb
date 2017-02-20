class CreatePaymentAccounts < ActiveRecord::Migration
  def change
    create_table :payment_accounts,id: false do |t|
    	t.belongs_to "purchase_account",:index=>true
    	t.column "payment_no",:integer
    	t.column "amount",:float
    	t.timestamps null: false
    end
  end
end
