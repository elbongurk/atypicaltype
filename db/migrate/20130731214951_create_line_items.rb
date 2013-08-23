class CreateLineItems < ActiveRecord::Migration
  def up
    create_table :line_items do |t|
      t.integer :cart_id, null: false
      t.integer :product_id, null: false
      t.uuid :photo_id, null: false
      t.integer :quantity, default: 1
    end
  end

  def down
    drop_table :line_items
  end
end
