class Fulfillment < ActiveRecord::Base
  belongs_to :order

  def self.recent
    having("shipped_on = MAX(shipped_on)").group(:id)
  end
end
