class CreateExpenseAccounts < ActiveRecord::Migration
  def change
   create_table :expense_accounts, id: false do |t|

    	t.primary_key "e_id"
    	t.column "type",:text, :null=>false
    	t.column "description",:text,:null=>false
    	t.column "cost",:integer,:null=>false
    	t.column  "dated",:date
    end
  end
end
