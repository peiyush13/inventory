class CreatePurchaseAccounts < ActiveRecord::Migration
  def change
    
	create_table :purchase_accounts,{:id=>false} do |t|
    	t.primary_key "bill_no"
    	t.column "company_name",:string,:limit => 50,:null=>false
    	t.column "cost",:float,:null=>false
    	t.column "place",:string,:limit => 50,:null=>false
    	t.timestamps :null=>false
    end
  end
end
