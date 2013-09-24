class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  belongs_to :photo

  def to_png
    renderer(:png)
  end

  def to_pdf
    renderer(:pdf)
  end

  def as_params(type)
    { photo_id: self.photo_id, product_id: self.product_id, format: type }
  end

  private

  def renderer(type)
    options = { type: type, brightness: self.brightness, contrast: self.contrast }
    Renderer.new(photo.url, photo.width, photo.height, options)
  end
end
