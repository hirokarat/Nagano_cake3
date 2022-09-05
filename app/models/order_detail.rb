class OrderDetail < ApplicationRecord
  def subtotal
    purchase_price*amount
  end
  
  belongs_to :item
	belongs_to :order
	
	enum maiking_status: { production_not_possible: 0, production_pending: 1, in_production: 2, production_complete: 3 }
end
