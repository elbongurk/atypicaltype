class Product < ActiveRecord::Base
  has_many :line_items
  default_scope { where active: true }

  def self.canvases
    where(good: "CANVAS")
  end

  def description
    case good
      when "CANVAS" then "Gallery Wrap Canvas"
    end
  end
end
