class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :buyer_id, null: false, foreign_key: { to_table: 'users' }
      t.references :seller_id, null: false, foreign_key: { to_table: 'users' }
      t.integer :order_total, null: false
      t.string :order_status, null: false
      t.timestamps
    end
  end
end
