class Item
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :unique => true
  
  has n, :warehouses, :through => Resource, :class_name => "ItemDetail"


end
