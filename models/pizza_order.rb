require_relative('../db/sql_runner.rb')
require_relative('customer.rb')

class PizzaOrder
  attr_accessor :topping, :quantity
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @customer_id = options["customer_id"].to_i
    @topping = options["topping"]
    @quantity = options["quantity"].to_i
  end

  def customer
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customer = SqlRunner.run(sql, values)
    return Customer.new(customer[0])
  end

  def save
    sql = "
      INSERT INTO orders (
        customer_id,
        topping,
        quantity
      )
      VALUES (
        $1, $2, $3
      )
      RETURNING * 
     "
    values = [@customer_id, @topping, @quantity]
    saved = SqlRunner.run(sql, values)
    @id = saved[0]["id"].to_i 
  end

  def self.all
    sql = "SELECT * FROM orders"
    values = []
    result = SqlRunner.run(sql, values)
    return result.map { |order| PizzaOrder.new(order) }
  end

  def self.delete_all
    sql = "DELETE FROM orders"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM orders WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_by_id(id)
    sql = "DELETE FROM orders WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end


  def update
    sql = "
      UPDATE orders
      SET (topping, quantity) = ($1, $2)
      WHERE id = $3
    "
    values = [@topping, @quantity, @id]
    SqlRunner.run(sql, values)
  end


end