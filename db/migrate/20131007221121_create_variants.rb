class CreateVariants < ActiveRecord::Migration
  def up
    create_table :variants do |t|
      t.integer :product_id, null: false
      t.boolean :active, null: false, default: true
      t.string :sku, null: false
      t.integer :number, null: false
      t.integer :size, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :variants
  end
end
