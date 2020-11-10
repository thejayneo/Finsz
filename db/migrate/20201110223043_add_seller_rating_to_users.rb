class AddSellerRatingToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :seller_rating, :float
  end
end
