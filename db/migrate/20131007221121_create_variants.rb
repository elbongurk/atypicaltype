class CreateVariants < ActiveRecord::Migration
  def up
    create_table :variants do |t|
      t.integer :product_id, null: false
      t.string :sku, null: false
      t.string :number, null: false
      t.integer :size_id
      t.integer :contrast_id
      t.integer :brightness_id
      t.decimal :price, precision: 8, scale: 2, null: false
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :variants
  end
end
