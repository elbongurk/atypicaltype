class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :variant
  belongs_to :photo

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
    Renderer.new(type, variant.size, photo.url, photo.width, photo.height)
  end
end
