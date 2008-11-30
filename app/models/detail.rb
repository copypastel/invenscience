class Detail
  include DataMapper::Resource
  
  property :id, Serial
  property :price, Integer
  property :quantity, Integer

  belongs_to :order
  belongs_to :item
  has 1, :warehouse, :through => :item

=begin
  def price=(new_price)
    attribute_set(:price, (new_price * 100).to_i)
  end
  
  def price
    p = attribute_get(:price)
    return nil if p.nil?
    attribute_get(:price) / 100.0
  end
=end
  
end