class OrderAddress < ApplicationRecord
  belongs_to :order_date

  # ここに記載したvalidatesはdate_address.rbに記載しました。
end
