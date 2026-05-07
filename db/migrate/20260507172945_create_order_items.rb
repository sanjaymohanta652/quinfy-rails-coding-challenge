class CreateOrderItems < ActiveRecord::Migration[8.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.string :name
      t.string :size
      t.text :add_ingredients
      t.text :remove_ingredients

      t.timestamps
    end
  end
end
