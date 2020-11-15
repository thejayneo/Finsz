class AddTypeToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :product_type, :string, null: false
  end
end
