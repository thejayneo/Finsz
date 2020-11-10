class AddBuyerRatingToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :buyer_rating, :float
  end
end
