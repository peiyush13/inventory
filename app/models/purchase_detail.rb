class PurchaseDetail < ActiveRecord::Base
	has_many :stock_list
	belongs_to :purchase_account
end
