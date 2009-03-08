class PriceBreak
  include DataMapper::Resource
  
  property :id, Serial
  property :breaks, Object

  has 1, :item
  
  before :save do
    infinity = 1.0/0
    self.breaks ||= { 1..infinity => nil }
  end
  
  def price_for(quantity)
    breaks.each do |key, value|
      return value if key.first <= quantity and quantity < key.last
    end
  end
  
end
