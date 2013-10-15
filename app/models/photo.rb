class Photo < ActiveRecord::Base
  belongs_to :user
  
  def created_time
    self.created_at.to_i
  end
  
  def modified_time
    self.modified_at.to_i
  end
end
