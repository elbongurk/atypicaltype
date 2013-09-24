class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.string :url, null: false
      t.integer :width, null: false
      t.integer :height, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :photos    
  end
end
