class Item
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :unique => true
  
  has n, :warehouses, :through => :item_detail


end
