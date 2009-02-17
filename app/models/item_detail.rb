class ItemDetail
  include DataMapper::Resource
  
  property :id, Serial
  
  belongs_to :warehouse
  belongs_to :item

end
