class Photo
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :id, :url, :width, :height

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def to_png
    renderer(:png)
  end

  def to_pdf
    renderer(:pdf)
  end

  protected

  def persisted?
    false
  end

  private

  def renderer(type)
    Renderer.new(self.url, self.width, self.height, type: type)
  end

end
