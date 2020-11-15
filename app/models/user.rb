class User < ApplicationRecord
  has_many :products
  has_many :sales, class_name: 'Order', foreign_key: :seller_id
  has_many :purchases, class_name: 'Order', foreign_key: :buyer_id
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
