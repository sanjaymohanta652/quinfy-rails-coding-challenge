class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :external_id, null: false
      t.string :state, null: false
      t.text :promotion_codes
      t.string :discount_code
      t.datetime :ordered_at
      t.decimal :total_price

      t.timestamps
    end
    
    add_index :orders, :external_id, unique: true
  end
end
