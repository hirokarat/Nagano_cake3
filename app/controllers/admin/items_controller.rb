class Admin::ItemsController < ApplicationController
  
  before_action :customer_shut_out
  before_action :authenticate_admin!
  def index
    @items = Item.all.page(params[:page]).per(10)
  end

  def new
    @item=Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
       flash[:notice] = "You have created Item successfully"
       redirect_to admin_item_path(@item.id)
    else
       render :new
    end
  end

  def show
    @item=Item.find(params[:id])
  end

  def edit
    @item=Item.find(params[:id])
  end

  def update
    @item=Item.find(params[:id])
    if @item.update(item_params)
       flash[:notice] = "You have update Item successfully"
       redirect_to admin_item_path(@item.id)
    else
       render :edit
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name,:introduction,:price,:image,:is_active,:genre_id)
  end
  
end
