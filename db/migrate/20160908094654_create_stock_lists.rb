class CreateStockLists < ActiveRecord::Migration
  def change
	 create_table :stock_list , id: false do |t|

      t.primary_key "item_id" 
      t.column "item_name" ,:string, :limit =>50,:null=>false
      t.column "price" ,:integer ,:null=>false
      t.column "stock" ,:integer,:default=>0
      t.timestamps null: false
    end
  end
end
