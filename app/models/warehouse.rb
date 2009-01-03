class Warehouse
  include DataMapper::Resource
  include Parser::Proxy
    
  property :id, Serial
  property :name, String, :nullable => false, :unique => true
  property :parser, Object, :nullable => false

  has n, :items  
 # has n, :details, :through => :items
  has n, :orders#, :through => :details  
  #Class Methods.  Instance methods inherited from parser
#  class << self
#    # Receive a url for an item. 
#    # Return an array with all items that were parsed from that url.
#    def parse(uri)
#      Warehouse.all.each {|w| return w.parse(uri) if w.parsable?(uri)}
#      nil
#    end
#  
   # def price(item, quantity = 1)
   #   item.price( item, quantity )
   # end

    # Need a much better name
#    def place_in_cart(order)
#      details = order.details
#      order.warehouses.each do |warehouse|
#        warehouse.place_in_cart(details.select {|d| d.warehouse == warehouse})
#      end
#    end
 # end
  
end