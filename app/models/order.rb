class Order < ApplicationRecord
  belongs_to :seller_id
  belongs_to :buyer_id
  belongs_to :product_id
end
