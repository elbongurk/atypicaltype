class CreateFulfillments < ActiveRecord::Migration
  def up
    create_table :fulfillments do |t|
      t.integer :order_id, null: false
      t.string :service
      t.string :tracking_code
      t.date :shipped_on, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :fulfillments
  end
end
