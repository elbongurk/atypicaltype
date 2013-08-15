class CreateOrders < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.integer :cart_id, null: false
    end
  end

  def down
    drop_table :orders
  end
end
