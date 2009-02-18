class Item
  include DataMapper::Resource
  
  property :id      , Serial
  property :quantity, Integer
  
  belongs_to :warehouse
  belongs_to :base_item
  
  validates_present :base_item
  
  before :save do 
    self.quantity ||= 0
  end
  
  def name
    base_item.name
  end
  
end
