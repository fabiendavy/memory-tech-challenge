class PagesController < ApplicationController
  def dashboard
    if params[:country]
      
    end

    @countries = get_countries
    @orders = get_orders_of_a_country
    raise

    @number_of_customers = get_numbers_of_customers
  end

  private

  def get_countries
    Customer.all.each_with_object([]) { |customer, arr| arr << customer.country unless arr.include?(customer.country) }
  end

  def get_numbers_of_customers
    params[:country] != 'All' ? Customer.where(country: params[:country]).count : Customer.count
  end

  def get_revenue
    Customer.where(country: params[:country]).each do |customer|
      customer.orders.
    end
  end

end
