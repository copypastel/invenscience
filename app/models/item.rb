class Item
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :nullable => false
  
  has n, :details
  has n, :orders, :through => :details

  # Check if this item is avaiable from the warehouse provided
  def available?( warehouse )
    
  end

end
