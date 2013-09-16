class CreatePhotos < ActiveRecord::Migration
  def up
    enable_extension 'uuid-ossp'

    create_table :photos, id: :uuid do |t|
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
