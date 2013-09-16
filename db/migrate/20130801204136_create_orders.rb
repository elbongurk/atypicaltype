class CreateOrders < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.integer :cart_id, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :address1, null: false
      t.string :address2
      t.string :city, null: false
      t.string :state, null: false
      t.string :postal_code, null: false
      t.string :transaction_id
      t.decimal :total, precision: 8, scale: 2
      t.decimal :shipping, precision: 8, scale: 2
      t.decimal :tax, precision: 8, scale: 2      
      t.timestamps null: false
    end
  end

  def down
    drop_table :orders
  end
end
