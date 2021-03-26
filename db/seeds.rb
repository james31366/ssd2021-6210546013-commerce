# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  Category.create(
    name: "Category #{n}",
    description: "Description #{n}"
  )
  Product.create(
    title: "Product #{n}",
    description: "Product Description #{n}",
    stock: n + 1,
    price: n + 100,
    seller: "Seller #{n}"
  )
end