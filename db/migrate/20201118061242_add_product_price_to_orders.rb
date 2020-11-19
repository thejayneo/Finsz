class AddProductPriceToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :product_price, :decimal
  end
end
