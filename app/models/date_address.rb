class DateAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :bilding, :phone_number, :order_date
end  