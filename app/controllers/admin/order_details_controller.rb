class Admin::OrderDetailsController < ApplicationController
  
  before_action :customer_shut_out
  
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail = OrderDetail.where(order_id: order_detail.order_id)
    order = order_detail.order
    order_detail.update(order_detail_params)
    if order_detail.all?{ |order_detail| order_detail.is_active === "production_complete" }
      order.update(complete_order_params)
    elsif order_detail.is_active === "in_production"
      order.update(order_params)
    end
    redirect_to admin_order_path(order_detail.order_id)
  end
  
   private
    def order_detail_params
      params.require(:order_detail).permit(:is_active).merge(is_active: params[:order_detail][:is_active].to_i)
    end

    def order_params
      params.permit(:is_active).merge(is_active: 2)
    end

    def complete_order_params
      params.permit(:is_active).merge(is_active: 3)
    end
  
end
