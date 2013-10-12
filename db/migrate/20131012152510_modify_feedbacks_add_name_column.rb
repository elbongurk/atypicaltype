class ModifyFeedbacksAddNameColumn < ActiveRecord::Migration
  def change
    add_column :feedbacks, :name, :string, null: false
  end
end
