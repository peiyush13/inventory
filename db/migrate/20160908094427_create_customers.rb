class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customer,id:false do |t|
    	t.primary_key "c_id"
    	t.column "customer_name",:string,:limit=>50,:null=>false
    	t.column "contact_no",:string ,:limit=>13
    	t.column "address" ,:text,:null=>false 
    end
  end
end
