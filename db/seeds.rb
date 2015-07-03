# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name: 'Test', last_name: 'One', email: 'test@one.com', username: 'test1', password: '1234')
User.create!(first_name: 'Test', last_name: 'Two', email: 'test@two.com', username: 'test2', password: '1234')
Product.create!(name: 'Apple', price: 2.99, description: 'Crunchy', seller: User.first)
Product.create!(name: 'Pear', price: 2.99, description: 'Sweet', seller: User.find(2))
Review.create!(comment: 'Nice!', product: Product.first, user: User.find(2))
Review.create!(comment: 'Cool!', product: Product.find(2), user: User.first)
CartItem.create!(product_id: 1, user_id: 1, unit_price: Product.first.price)
