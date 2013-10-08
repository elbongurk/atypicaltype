class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :variant
  belongs_to :photo

  has_many :orders, through: :cart

  def total
    variant.try(:price) * quantity
  end

  def to_png
    renderer(:png)
  end

  def to_pdf
    renderer(:pdf)
  end

  private

  def renderer(type)
    options = { type: type, brightness: variant.brightness, contrast: variant.contrast }
    Renderer.new(photo.url, photo.width, photo.height, options)
  end
end
