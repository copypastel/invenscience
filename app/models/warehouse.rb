class Warehouse
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :nullable => false
  property :parser, Object

  has n, :items  
  has n, :details, :through => :items
  has n, :orders, :through => :details

  
  def method_missing(method_name, *args)

    extend parser unless parser.nil?

    if self.respond_to?(method_name)
      self.send( method_name, *args)
    else
      super
    end
    
  end

  # Receive a url for an item.
  # Return an array with all items that were parsed from that url.
  def self.parse(uri)
    Warehouse.all.each {|w| return w.parse(uri) if w.parsable?(uri)}
    nil
  end
  
  def self.price(item, quantity = nil)
    item.warehouse.price( item, quantity )
  end

end