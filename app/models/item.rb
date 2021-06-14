class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  belongs_to :user

  has_one_attached :image

  with_options presence: true do
    validates :name, :info, :image
    validates :price, format: { with: /\A[0-9]+\z/i, message: 'は半角数字で記入して下さい' },
                      numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :category_id, :sales_status_id, :shipping_fee_status_id,
              :prefecture_id, :scheduled_delivery_id, numericality: { other_than: 1, message: 'のセレクタから選択して下さい' }
  end
end
