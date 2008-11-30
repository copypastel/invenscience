class Detail
  include DataMapper::Resource
  
  property :id, Serial
  property :price, BigDecimal
  property :quantity, Integer

  belongs_to :order
  belongs_to :item
  has 1, :warehouse, :through => :item
  
end