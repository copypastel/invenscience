class Warehouse
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :unique => true
  property :parser, Object, :nullable => false
  
  has n, :items
  has n, :base_items, :through => Resource, :class_name => "Item"
  
  def stocked_items
    #TODO: is this safe?  Do I need to do :warehouse_id => ?...
    Item.all({:warehouse_id => self.id, :quantity.gt => 0})
  end
  
  def add(item)
    #the item must be valid and already be saved
    return false unless item.valid? and not item.id.nil?

    if item.class == BaseItem
      base_item = item
      item = self.items.first(:conditions => {:base_item_id => item.id}) ||
             self.items.create(:base_item_id => base_item.id)
    elsif item.class == Item and item.warehouse != self
      item = self.items.first(:conditions => {:base_item_id => item.base_item.id}) ||
             self.items.create(:base_item_id => item.base_item.id)
    end

    item.quantity += 1
    if (returns = item.save) then self.items.reload; end
    returns
  end
  
  def remove(item)
    if item.class == BaseItem
      item = self.items(:conditions => {:base_item_id => item.id}).first
    elsif item.class == Item
      item = self.items(:conditions => {:base_item_id => item.base_item.id}).first
    end
    unless item.nil?
      item.quantity -= 1
      item.save
    else 
      false
    end
  end
end
