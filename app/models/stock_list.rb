class StockList < ActiveRecord::Base
	scope :sorted, lambda { order("stock_lists.item_id ASC") }
	scope :sort_by_price, lambda { order("stock_lists.price ASC") }
	scope :sort_by_price_desc, lambda { order("stock_lists.price DESC") }
	scope :sort_by_quantity, lambda { order("stock_lists.stock ASC") }
	scope :sort_by_quantity_desc, lambda { order("stock_lists.stock DESC") }

end
