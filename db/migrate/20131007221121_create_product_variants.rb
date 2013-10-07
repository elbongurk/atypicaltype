class CreateProductVariants < ActiveRecord::Migration
  def up
    create_table :product_variants do |t|
      t.integer product_id, null: false
      t.string :model
      t.string :brand
      t.string :color
      t.string :size
      t.decimal :price, precision: 8, scale: 2, null: false
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :product_variants
  end
end
