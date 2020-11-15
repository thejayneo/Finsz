class Product < ApplicationRecord
    belongs_to :seller, class_name: 'User'
    has_one_attached :picture
end
