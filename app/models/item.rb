class Item
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :nullable => false
  property :description, Text
  property :uri, Text, :nullable => false
  property :stock, Integer
  property :updated_at, DateTime
  property :created_at, DateTime
  
  has n, :details
  has n, :orders, :through => :details
  belongs_to :warehouse
  
  # Check if this item is avaiable from the warehouse provided
  def available?( warehouse )
    
  end

  def price(quantity = nil)
    warehouse.price(self, quantity)
  end

end
