class AddProductNameToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :product_name, :string
  end
end
