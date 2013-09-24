class Photo < ActiveRecord::Base
  belongs_to :user

  def line_items
    Product.all.each.map do |product|
      LineItem.new(product_id: id, photo_id: self.id)
    end
  end
end
