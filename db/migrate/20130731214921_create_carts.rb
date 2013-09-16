class CreateCarts < ActiveRecord::Migration
  def up
    create_table :carts do |t|
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :carts
  end
end
