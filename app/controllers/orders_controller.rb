class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order
  before_action :set_present
  def index
    @date_address = DateAddress.new
  end

  def create
    @date_address = DateAddress.new(order_date_params)
    if @date_address.valid?
      pay_item
      @date_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_date_params
    params.require(:date_address).permit(:postal_code, :prefecture_id, :city, :address, :bilding, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_order
    @order = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # 秘密鍵代入した環境変数を書いています
    Payjp::Charge.create(
      amount: @order.price,
      card: order_date_params[:token],
      currency: 'jpy'
    )
  end

  def set_present
    redirect_to root_path if (@order.user_id == current_user.id) || @order.order_date.present?
  end
end
