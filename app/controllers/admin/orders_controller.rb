class Admin::OrdersController < ApplicationController

  before_action :customer_shut_out
  before_action :authenticate_admin!
  
  def index
    case params[:index]
    when "0"
      @customer = Customer.find(params[:customer_id])
      @orders = @customer.orders.all.order(created_at: :desc).page(params[:page]).per(10)
    else
      @orders = Order.all.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def show
    @order=Order.find(params[:id])
  end

  def update
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
