class Public::OrdersController < ApplicationController

  include ApplicationHelper
  before_action :to_confirm, only: [:show]
  before_action :authenticate_customer!

  def new
    if cart_items = CartItem.where(customer_id: current_customer.id).present?
      @order = Order.new
      @addresses= Address.where(customer: current_customer)
    else
      redirect_to cart_items_path, notice: "カートに商品が入っておりません"
    end
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.total_payment = billing(@order)
    if params[:order][:select] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select] == "1"
      @address = Address.find(params[:address][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end

  end

  def complete
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)

    if @order.save
      @cart_items.each do |cart|
      order_detail = OrderDetail.new
      order_detail.item_id = cart.item_id
      order_detail.order_id = @order.id
      order_detail.amount = cart.amount
      order_detail.price = cart.item.price
      order_detail.save
      end
      flash[:notice] = "ご注文が確定しました。"
      redirect_to complete_orders_path
    else
    @order = Order.new(order_params)
    render :new
    end

    if params[:order][:select] == "1"
      current_customer.addresses.create(address_params)
    end

    @cart_items.destroy_all
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name,:total_payment)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

  def to_confirm
    redirect_to items_path if params[:id] == "confirm"
  end

end
