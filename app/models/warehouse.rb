class Warehouse
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :unique => true
  property :parser, Object, :nullable => false
  
  has n, :items, :through => Resource, :class_name => "ItemDetail"
  
  def add(item)
    self.items.push(item)
  end
  
  def remove(item)
    self.items.delete(item)
  end
end
