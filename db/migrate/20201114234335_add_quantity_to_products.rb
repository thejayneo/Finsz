class AddQuantityToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :quantity, :integer, null: false
  end
end
