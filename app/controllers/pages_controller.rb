class PagesController < ApplicationController
  def dashboard
    if params[:country]
      selected_country = params[:country] if params[:country] != 'All'
    end

    @countries = get_countries
    @revenue = get_revenue(selected_country)
    @average_revenue = (@revenue.fdiv(get_orders_number(selected_country))).round(2)
    @number_of_customers = get_customers_number(selected_country)
    # raise
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

end
