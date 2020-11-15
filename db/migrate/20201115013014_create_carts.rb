class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.references :buyer_id, null: false, foreign_key: { to_table: 'users' }
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end
  end
end
