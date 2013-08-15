class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :oauth_token, null: false
      t.integer :oauth_id, null: false
      t.string :username, null: false
      t.string :avatar_url, null: false
      t.timestamps null: false
    end

    add_index :users, :oauth_id, unique: true
  end
  
  def down
    drop_table :users
  end
end
