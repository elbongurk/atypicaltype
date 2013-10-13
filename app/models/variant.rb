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
  
  def size_code
    self.sku[1..6].downcase
  end

  def shotPart
    self.sku[0..6].downcase
  end
  
  def shotFull(number)
    "#{self.shotPart}-f#{number}.jpg"
  end

  def shotThumb(number)
    "#{self.shotPart}-t#{number}.jpg"
  end

  def name
    width = self.sku[1..2]
    height = self.sku[4..6]
    "#{width}\" X #{height}\""
  end
end
