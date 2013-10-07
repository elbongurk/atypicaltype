class CreateCollections < ActiveRecord::Migration
  def up
    create_table :collections do |t|
      t.string :name, null: false
      t.timestamps, null: false
    end
  end
  
  def down
    drop_table :collections
  end
end
