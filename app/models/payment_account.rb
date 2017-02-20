class PaymentAccount < ActiveRecord::Base
	belongs_to :purchase_account, dependent: :destroy
	scope :sort_by_cost, lambda { order("purchase_accounts.cost ASC") }
	scope :sort_by_cost_desc, lambda { order("purchase_accounts.cost DESC") }
	scope :sort_by_date_desc, lambda { order("purchase_accounts.created_at DESC") }
end
