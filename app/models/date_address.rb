class DateAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :bilding, :phone_number, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'input correctly' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'のセレクタから選択して下さい' }
    validates :city, :address, :user_id, :item_id, :token
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'input only number' }
  end

  def save
    order_date = OrderDate.create(item_id: item_id, user_id: user_id)
    
    OrderAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, bilding: bilding,
                        phone_number: phone_number, order_date_id: order_date.id)
  end
end
