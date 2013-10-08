class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :products
  end
end
