class Admin::CustomersController < ApplicationController
  before_action :customer_shut_out
  before_action :authenticate_admin!
  
  def index
    @customers=Customer.page(params[:page]).per(10)
  end

  def show
    @customer=Customer.find(params[:id])
  end

  def edit
    @customer=Customer.find(params[:id])
  end

  def update
    @customer=Customer.find(params[:id])
    @customer.update(customer_params)
    render action: :show
  end
  
  private
  
  def customers_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:email,:encrypted_password,:postal_code,:address,:telephone_number,:is_active)  
  end
  
end
