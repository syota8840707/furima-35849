class OrderDate < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :order_address
end
