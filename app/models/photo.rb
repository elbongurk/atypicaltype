class Photo < ActiveRecord::Base
  belongs_to :user

  def line_items
    Product.all.each.map do |product|
      LineItem.new(product_id: id, photo_id: self.id)
    end
  end

  def to_png(options = {})
    renderer(:png, options)
  end

  def to_pdf(options = {})
    renderer(:pdf, options)
  end

  private

  def renderer(type, options = {})
    Renderer.new(self.url, self.width, self.height, options.merge(type: type))
  end
end
