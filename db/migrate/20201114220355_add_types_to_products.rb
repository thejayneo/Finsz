class AddTypesToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :plans_only, :boolean, null: false
    add_column :products, :kit_and_plans, :boolean, null: false
    add_column :products, :assembled_module, :boolean, null: false
  end
end
