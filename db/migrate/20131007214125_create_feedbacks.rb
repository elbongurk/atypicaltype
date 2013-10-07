class CreateFeedbacks < ActiveRecord::Migration
  def up
    create_table :feedbacks do |t|
      t.string :email, null: false
      t.text :message, null: false
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :feedbacks
  end
end
