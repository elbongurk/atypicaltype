class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.string :size
      t.decimal :price, precision: 8, scale: 2
    end
  end

  def down
    drop_table :products
  end
end
