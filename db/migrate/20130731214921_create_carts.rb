class CreateCarts < ActiveRecord::Migration
  def up
    create_table :carts do |t|
      t.integer :user_id, null: false
      t.integer :orders_count, default: 0
      t.timestamps null: false
    end

    add_index :carts, [:user_id, :orders_count]
  end

  def down
    drop_table :carts
  end
end
