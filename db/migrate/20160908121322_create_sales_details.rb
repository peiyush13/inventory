class CreateSalesDetails < ActiveRecord::Migration
  def change
    create_table :sales_details,{:id => false} do |t|

 	  t.belongs_to "sale" ,:index=>true 
      t.belongs_to "stock_list", :index=>true
      t.float "quantity"
      
    end
  end
end
