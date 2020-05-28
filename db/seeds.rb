# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

puts "Destroying all..."
OrderProduct.destroy_all
Order.destroy_all
Customer.destroy_all
Product.destroy_all

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'db/memory-tech-challenge-data.csv'

customers = []
customer_ids = []
orders = []
order_ids = []
products = []
product_codes = []
order_products = []

puts "Parsing file..."
CSV.foreach(filepath, csv_options) do |row|
  if !(customer_ids.include?(row['customer_id']))
    customers << Customer.new(previous_id: row['customer_id'], country: row['country'])
    customer_ids << row['customer_id']
  end

  if !(order_ids.include?(row['order_id']))
    orders << Order.new(previous_id: row['order_id'], date: row['date'], customer: customers.last)
    order_ids << row['order_id']
  end

  if !(product_codes.include?(row['product_code']))
    products << Product.new(code: row['product_code'], description: row['product_description'], unit_price: row['unit_price'].to_f)
    product_codes << row['product_code']
  end

  current_product = ""
  products.each_with_index do |product_code, index|
    current_product = products[index] if row['product_code'] == product_code.code
  end

  order_products << OrderProduct.new(product: current_product, order: orders.last, quantity: row['quantity'].to_i)
end

puts "Importing data..."
Customer.import(customers)
Order.import(orders)
Product.import(products)
OrderProduct.import(order_products)
puts "Finished !"
