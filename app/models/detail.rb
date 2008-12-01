class Detail
  include DataMapper::Resource
  
  property :id, Serial
  property :price, BigDecimal
  property :quantity, Integer

  belongs_to :cart
  belongs_to :order
  belongs_to :item
  # Datamapper still doesn't implement has 1, :through
  #has 1, :warehouse, :through => :item
  
  def warehouse
    item.warehouse
  end
  
end