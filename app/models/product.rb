class Product < ActiveRecord::Base
  has_many :variants
  
  def to_param
    "#{self.id}-#{self.name.downcase}"
  end
end