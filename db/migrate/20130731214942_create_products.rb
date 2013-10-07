class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.boolean :active, null: false, default: true
      t.integer :collection_id, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :products
  end
end
