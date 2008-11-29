class Detail
  include DataMapper::Resource
  
  property :id, Serial
  property :price, Integer
  property :quantity, Integer

  belongs_to :warehouse
  belongs_to :order
  belongs_to :item

end
