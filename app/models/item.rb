class Item
  include DataMapper::Resource
  
  property :id      , Serial
  property :quantity, Integer
  
  belongs_to :warehouse
  belongs_to :base_item
  belongs_to :price_break
  
  validates_present :base_item
    
  before :save do 
    self.quantity ||= 0
    self.price_break ||= PriceBreak.create
  end
  
  def name
    base_item.name
  end
  
  def price_for(quantity)
    self.price_break.price_for(quantity)
  end
  
end
