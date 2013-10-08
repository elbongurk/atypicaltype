class CreateLineItems < ActiveRecord::Migration
  def up
    create_table :line_items do |t|
      t.integer :cart_id, null: false
      t.uuid :photo_id, null: false
      t.integer :variant_id, null: false
      t.integer :quantity, default: 1, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :line_items
  end
end
