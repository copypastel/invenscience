class Order
  include DataMapper::Resource
  
  # Remember to implement enumerable module for Order
  
  property :id, Serial
  property :pending, Boolean, :default => true

  alias :pending :pending?

  has n, :details
  has n, :items, :through => :details
  has n, :warehouses, :through => :items

  # Place the order
  # Needs to go organize the details according to warehouse, and place an order for each
  def place
  end
  
  def add(item, quantity)
    return nil if quantity <= 0
    if items.include? item
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
    total = 0
    details.each {|d| total += d.price * d.quantity }
    total / 100.0 # Divide by 100.0 since prices in details are saved in cents
  end
  

end
