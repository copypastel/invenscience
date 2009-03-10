class Order
  include DataMapper::Resource
  include ItemManager
  
  property :id, Serial
  
  has n, :order_items
  has n, :base_items, :through => Resource, :class_name => "Item"

  belongs_to :project
  
  validates_present :project
  
  #####################################
  #        hooks for ItemManager      #
  alias item_hook order_items         #
  def item_class_hook; OrderItem; end #
  #####################################
  
end
