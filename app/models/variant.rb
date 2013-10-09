class Variant < ActiveRecord::Base
  has_many :line_items
  belongs_to :product
  default_scope { where active: true }

  def self.from_param(param)
    where(sku: param).first
  end

  def to_param
    self.sku
  end

  def contrast
    self.sku[4..5].to_i  
  end
  
  def brightness
    self.sku[6..7].to_i
  end
  
  def actionImage(number)
    "#{self.sku[0..3].downcase}-#{number}.jpg"
  end

  def name
    width = self.sku[1].to_i(16)
    height = self.sku[3].to_i(16)
    "#{width} \" X #{height}\""
  end
end
