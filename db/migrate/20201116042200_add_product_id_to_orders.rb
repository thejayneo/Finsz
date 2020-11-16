class AddProductIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :product_id, null: false, foreign_key: { to_table: 'products'}
  end
end
