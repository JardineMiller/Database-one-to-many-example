require_relative('../db/sql_runner.rb')
require_relative('pizza_order.rb')

class Customer
  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(details)
    @id = details["id"].to_i if details["id"]
    @first_name = details['first_name']
    @last_name = details['last_name']
  end

  def pizza_orders
    sql = "SELECT * FROM orders WHERE customer_id = $1"
    values = [@id]
    orders = SqlRunner.run(sql, values)
    return orders.map {|order| PizzaOrder.new(order)}
  end

  def self.all
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map {|customer| Customer.new(customer)}
  end

  def save
    sql = "INSERT INTO customers (
        first_name,
        last_name
      )
      VALUES (
        $1, $2
      )
      RETURNING *"
    values = [@first_name, @last_name]
    saved = SqlRunner.run(sql, values)
    @id = saved[0]["id"].to_i 
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end