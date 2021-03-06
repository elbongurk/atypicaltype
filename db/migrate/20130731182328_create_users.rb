class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :oauth_token, null: false
      t.integer :oauth_id, null: false
      t.string :username, null: false
      t.string :name
      t.string :avatar_url, null: false
      t.boolean :send_process_email, null: false, default: true
      t.boolean :send_ship_email, null: false, default: true
      t.timestamps null: false
    end

    add_index :users, :oauth_id, unique: true
  end
  
  def down
    drop_table :users
  end
end
