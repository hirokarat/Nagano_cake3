class Admin::HomesController < ApplicationController
  
  before_action :customer_shut_out
  
  def top
   @orders = Order.page(params[:page]).per(10)
  end
end
