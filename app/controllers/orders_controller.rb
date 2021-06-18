class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_order, only: [:index, :create]
  def index
    
    @date_address = DateAddress.new
  end
  def create
    
    @date_address = DateAddress.new(order_date_params)
    if @date_address.valid?
      @date_address.save
      redirect_to root_path
    else
      render :index
    end

  end 

  private

  def order_date_params
    params.require(:date_address).permit(:postal_code, :prefecture_id, :city, :address, :bilding, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end  
  def set_order
    @order = Item.find(params[:item_id])
  end  

end
