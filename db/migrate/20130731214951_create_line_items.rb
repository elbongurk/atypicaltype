class CreateLineItems < ActiveRecord::Migration
  def up
    enable_extension 'uuid-ossp'

    create_table :line_items, id: :uuid do |t|
      t.integer :cart_id, null: false
      t.integer :product_id, null: false
      t.integer :photo_id, null: false
      t.integer :brightness, default: 0, null: false
      t.integer :contrast, default: 0, null: false
      t.integer :quantity, default: 1, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :line_items
  end
end
