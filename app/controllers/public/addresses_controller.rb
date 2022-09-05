class Public::AddressesController < ApplicationController
  
  before_action :authenticate_customer!
 
  def index
    @address = Address.new
    @customer=current_customer
    @addresses = @customer.addresses
  end

  def create
    @address =Address.new(address_params)
    @address.customer_id = current_customer.id
    @addresses = current_customer.addresses
    if @address.save!
      flash[:notice] = "配送先を登録しました。"
      redirect_to public_addresses_path
    else
      render :index
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    flash[:alert] = "配送先を削除しました。"
    redirect_to public_addresses_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(deliver_destination_params)
      flash[:notice] = "配送先情報を変更しました。"
      redirect_to public_addresses_path
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

  def baria_customer
    unless Address.find(params[:id]).customer.id.to_i == current_customer.id
      redirect_to public_my_page_path
    end
  end

  
  
end
