class Admin::OrdersController < ApplicationController

  before_action :customer_shut_out

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order=Order.find(params[:id])
  end

  def update
    # @order = Order.find(params[:id])
    # @order_details= @order.order_details
    # @order.update(order_params)
    # if @order.status === 'payment_confirmation'
    #   @order_details.each do |order_detail|
    #     @order_detail.update(order_detail_params)
    #   end
    # end
    # @orders = Order.page(params[:page]).per(10)
    # redirect_to admin_order_path(@order)
     @order = Order.find(params[:id])
     @order_details = @order.order_details
    if @order.update(order_params)
        @order.change_order_details_status
       flash[:notice] = "登録情報を変更しました!"
       redirect_to admin_order_path(@order)
    else
       render 'show'
    end
  end



  private

    def order_detail_params
      params.require(:order_detail).permit(:making_status)
    end

    def order_params
      params.require(:order).permit(:status)
    end

end
