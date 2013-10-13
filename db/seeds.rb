# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Product.create(name: "Canvas", description: "Gallery Wrap Canvas").tap do |product|
  # 12 x 12 Canvas
  Variant.create(product_id: product.id, number: 823, size: 1080, price: 69.00, sku: "C12X12")
  
  # 16 x 16 Canvas
  Variant.create(product_id: product.id, number: 824, size: 1368, price: 79.00, sku: "C16X16")
end
