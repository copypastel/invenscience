class Order
  include DataMapper::Resource
  
  # Remember to implement enumerable module for Order
  
  property :id, Serial
  property :pending, Boolean, :default => true

  alias :pending :pending?

  has n, :details
  has n, :items, :through => :details
  # Causes a stack overflow for some reason
  #has n, :warehouses, :through => :items 
  has n, :carts

  # Place the order
  # Needs to go organize the details according to warehouse, and place an order for each
  def place
    Warehouse.place_in_cart(self)
    carts
  end
  
  # Warning, this is much slower since it's not using SQL at the moment. FIX... eventually. 
  def warehouses
    ws = []
    items.each { |i| ws << i.warehouse unless ws.include? i.warehouse}
    ws
  end
  
  def add(item, quantity)
    return nil if quantity <= 0
    unless items.include?(item).nil?
      detail = details.first(:item_id => item.id)
      detail.quantity += quantity
      detail.price = item.price(detail.quantity) * 100
      detail.save
      return detail
    else
      price = item.price(quantity) * 100
      return Detail.create(:item => item, :quantity => quantity, :price => price, :order => self)
    end
  end
  
  # Return total for the order
  def total
    total
    details.each {|d| total += d.price * d.quantity }
    total / 100.0 # Divide by 100.0 since prices in details are saved in cents
  end
  

end
