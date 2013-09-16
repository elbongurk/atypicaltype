class Product < ActiveRecord::Base
  has_many :line_items

  def self.active
    where(active: true)
  end

  def description
    case good
      when "CANVAS" then "Gallery Wrap Canvas"
    end
  end
end
