class OrderItem
  include DataMapper::Resource
  
  property :id, Serial
  property :quantity, Integer
  
  belongs_to :order
  belongs_to :base_item
  
  validates_present :base_item
  
  before :save do 
    self.quantity ||= 0
  end

end
