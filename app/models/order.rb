class Order
  include DataMapper::Resource
  
  # Remember to implement enumerable module for Order
  
  property :id, Serial
  property :pending, Boolean

  alias :pending?, :pending

  has n, :details
  has n, :items, :through => :details

  # Place the order
  # Needs to go organize the details according to warehouse, and place an order for each
  def place
  end
  
  # Return total for the order
  def total
    total = 0
    details.each {|d| total += d.price * d.quantity }
    total / 100.0 # Divide by 100.0 since prices in details are saved in cents
  end
  

end
