class Sale < ActiveRecord::Base
	belongs_to :customer
	scope :sorted, lambda { order("sales.sale_no ASC") }
	scope :sort_by_cost, lambda { order("sales.total ASC") }
	scope :sort_by_cost_desc, lambda { order("sales.total DESC") }
	scope :sort_by_date_desc, lambda { order("sales.created_at DESC") }
end
