class Photo
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :id, :url, :width, :height

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def to_png(options = {})
    renderer(:png, options)
  end

  def to_pdf(options = {})
    renderer(:pdf, options)
  end

  protected

  def persisted?
    false
  end

  private

  def renderer(type, options = {})
    Renderer.new(self.url, self.width, self.height, options.merge(type: type))
  end

end
