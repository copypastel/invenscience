class PriceBreak
  include DataMapper::Resource
  
  property :id, Serial

  has 1, :item

end
