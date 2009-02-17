class Warehouse
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :unique => true
  property :parser, Object, :nullable => false
  
  has n, :items, :through => :item_detail
  
  def add(item)
    self.items.push(item)
  end
  
  def remove(item)
    item.warehouse_id = nil
    item.save
  end
end
