class ExpenseAccount < ActiveRecord::Base
	scope :sorted, lambda { order("expense_accounts.e_id ASC") }
	scope :sort_by_cost, lambda { order("expense_accounts.cost ASC") }
	scope :sort_by_cost_desc, lambda { order("expense_accounts.cost DESC") }
	scope :sort_by_date_desc, lambda { order("expense_accounts.dated DESC") }

end
