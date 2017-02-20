class CreatePurchaseDetails < ActiveRecord::Migration
  def change
    create_table :purchase_details,id: false do |t|
      t.belongs_to "purchase_account" ,:index=>true 
      t.belongs_to "stock_list", :index=>true
      t.float "quantity"
    end
  end
end
