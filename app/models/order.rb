class Order
  include DataMapper::Resource
  include ItemManager
  property :id, Serial
  
  has n, :order_items
  has n, :base_items, :through => Resource, :class_name => "OrderItem"

  #############################
  #   hooks for ItemManager   #
  alias item_hook order_items #
  #############################

end
