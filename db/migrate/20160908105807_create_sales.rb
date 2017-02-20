class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales ,{:id => false }do |t|
	  t.primary_key "sale_no" 
      t.belongs_to "customer", :index=>true
      t.float "total",:null => false
      t.timestamps null: false
    end
  end
end
