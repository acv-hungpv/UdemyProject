# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all
auto_inc_val = 1
table = 'products'
binding.pry
ApplicationRecord.connection.execute(
"ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}"
)

# Product.create!(title: 'Ruby Book', description: 'learn Ruby Programing', price: 12.99, published: false)
# Product.create!(title: 'jQuery Book', description: 'learn jQuery', price: 11.99, published: true)
# Product.create!(title: 'SASS Book', description: 'Learn CSS with SASS', price: 11.99, published: true)