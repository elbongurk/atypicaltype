class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.integer :number, null: false
      t.boolean :active, null: false, default: true
      t.string :good, null: false
      t.string :model
      t.string :brand
      t.string :color
      t.string :size
      t.decimal :price, precision: 8, scale: 2, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :products
  end
end
