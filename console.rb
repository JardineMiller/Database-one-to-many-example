require('pry-byebug')
require_relative('models/pizza_order.rb')
require_relative('models/customer.rb')
require('pp')

customer1 = Customer.new({
  'first_name' => 'Darth',
  'last_name' => 'Vader'
})

customer2 = Customer.new({
  'first_name' => 'Luke',
  'last_name' => 'Skywalker'
})

customer1.save

pp Customer.all
# customer2.save
# pp Customer.all

order1 = PizzaOrder.new({ 
  'customer_id' => customer1.id,
  'quantity'=> '1', 
  'topping'=> 'Napoli'
})

order2 = PizzaOrder.new({ 
  'customer_id' => customer1.id,
  'quantity'=> '1', 
  'topping'=> 'Quattro Formaggi' 
})

order1.save
order1.quantity = 100
order1.update

# order2.save

pp PizzaOrder.all

# PizzaOrder.delete_by_id(1)

# pp order1.customer
# # order2.save

pp customer1.pizza_orders


# PizzaOrder.delete_all
# Customer.delete_all

 
 # binding.pry
 nil