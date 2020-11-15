class AddUserIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :seller_id, null: false, foreign_key: { to_table: 'users' }
  end
end
