class OrderDetail < ApplicationRecord
  def subtotal
    purchase_price*amount
  end
  
  def change_order_status
    if self.making_status == "in_production"
      self.order.update(status: "in_production")
    elsif OrderDetail.where(order_id: self.order_id).pluck(:making_status).all?{ |making_status| making_status == "production_complete" }
      self.order.update(status: "preparing_delivery")
    end
  end
  
  belongs_to :item
	belongs_to :order
	
	enum making_status: { production_not_possible: 0, production_pending: 1, in_production: 2, production_complete: 3 }
end
