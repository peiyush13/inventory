class PurchaseAccount < ActiveRecord::Base
	scope :sorted, lambda { order("purchase_accounts.bill_no ASC") }
	has_many :payment_accounts
end
