class PagesController < ApplicationController
  def dashboard
    if params[:country]
      selected_country = params[:country] if params[:country] != 'All'
    end

    @countries = get_countries
    @revenue = get_revenue(selected_country)
    @average_revenue = (@revenue.fdiv(get_orders_number(selected_country))).round(2)
    @number_of_customers = get_customers_number(selected_country)
    @data_chart = data_chart(selected_country)
  end

  private

  def get_countries
    Customer.all.each_with_object([]) { |customer, arr| arr << customer.country unless arr.include?(customer.country) }
  end

  def get_customers_number(country)
    country ? Customer.where(country: country).count : Customer.count
  end

  def get_orders_number(country)
    country ? Order.where(customer: Customer.where(country: country)).count : Order.count
  end

  def get_revenue(country)
    total_revenue = 0
    if country
      Customer.where(country: country).each do |customer|
        customer.orders.each do |order|
          total_revenue += order.total_price
        end
      end
    else
      # Order.all.each { |order| total_revenue += order.total_price }
      OrderProduct.all.each do |order_product|
        product = Product.find(order_product.product_id)
        total_revenue += product.unit_price * order_product.quantity
      end
    end
    total_revenue.round(1)
  end

  def data_chart(country)
    # we grab all the corresponding orders
    @orders = []
    if country
      Customer.where(country: country).each { |customer| @orders << customer.orders }
    else
      @orders = Order.all
    end
    @orders.flatten!
    
    # we create a hash with the month as the key and all the orders for this month
    monthly_data = Hash.new { |h, k| h[k] = [] }
    @orders.each do |order|
      monthly_data[order.date.month] << order
    end

    # we create a hash with the month as the key again, and the sum of the orders for this month as the value
    monthly_revenues = Hash.new(0)
    monthly_data.keys.each do |key, value|
      monthly_data[key].each do |order|
        monthly_revenues[key] += order.total_price
      end 
    end

    # we add the missing month and instanciate them to 0
    (1..12).each { |num| monthly_revenues[num] += 0 }

    # we convert the hash into an array of array and get the name of the month ex: {1: 235} => [['January', 235]]
    monthly_array = monthly_revenues.sort
    monthly_array.each do |month|
      letter_month = Date.new(2020, month[0], 1).strftime('%B')
      month[0] = letter_month
      month[1] = month[1].round(2)
    end
    monthly_array
  end

end
