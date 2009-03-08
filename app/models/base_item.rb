class BaseItem
  include DataMapper::Resource
  
  property :id, Serial

  property :name, String, :unique => true, :nullable => false
  
  has n, :warehouses, :through => Resource, :class_name => "Item"
end
