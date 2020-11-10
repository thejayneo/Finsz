class AddDisplayNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :display_name, :string, null: false
    add_index :users, :display_name, unique: true
  end
end
