class PriceBreak
  include DataMapper::Resource
  
  property :id, Serial
  property :breaks, Object

  has 1, :item
  
  before :save do
    infinity = 1.0/0
    self.breaks ||= { 1...infinity => nil }
  end
  
  def price_for(quantity)
    breaks.each do |range, price|
      return price if range.include?(quantity)
    end
  end
  
  #example while coding... existing range is 1...infinity
  #passing values of 5..10, 5
  def add_break(range,price)
    found_range, found_price = [nil,nil]
    range = (range.first...(range.last+1)) unless range.exclude_end?
    if self.breaks.any? { |range_, price_| found_range = range_; found_price = price_; range_.include?(range.first)}
      #remove 1..infinity
      remove_break(found_range)
      #add a new break 1...5 with old price
      add_break(found_range.first...range.first,found_price) unless found_range.first == range.first
      #add a new break 5...10 with new price
      add_break(range,price)
      #add a new break 10..infinity with old price
      add_break(range.last...found_range.last,found_price) unless found_range.last == range.last
    else
      self.breaks[range] = price
    end
    self.save
  end
  
  def remove_break(range)
    self.breaks.delete(range)
    #If all breaks removed set to nil so that range will be reset
    self.breaks = nil if self.breaks.size == 0
    self.save
  end
  
  def ranges
    breaks.collect {|range,price| range}
  end
  
end
