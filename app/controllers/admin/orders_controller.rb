class Admin::OrdersController < ApplicationController
  
  before_action :customer_shut_out
  
  def index
    @orders = Order.page(params[:page]).per(10)
  end
  
  def show
    @order=Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order_details= @order.order_details
    @order.update(order_params)
    if @order.order_status === "入金確認"
      order_details.each do |order_detail|
        order_detail.update(order_detail_params)
      end
    end
    @orders = Order.page(params[:page]).per(10)
    redirect_to admin_orders_path
  end

  
  
  private

    def order_detail_params
      params.permit(:is_active).merge(is_active: 1)
    end

    def order_params
      params.require(:order).permit(:is_active).merge(is_active: params[:order][:is_active].to_i)
    end
  
end
