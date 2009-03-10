class Warehouse
  include DataMapper::Resource
  include ItemManager
  
  property :id, Serial
  property :name, String, :unique => true
  property :parser, Object, :nullable => false
  
  has n, :items
  has n, :base_items, :through => Resource, :class_name => "Item"
  
  ################################
  #    hooks for ItemManager     #
  alias item_hook items          #
  def item_class_hook; Item; end #
  ################################
  
  def stocked_items
    #TODO: is this safe?  Do I need to do :warehouse_id => ?...
    Item.all({:warehouse_id => self.id, :quantity.gt => 0})
  end
  
end
