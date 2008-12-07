module Parser
  # A class wishing to use the various parsers should include the proxy module.
  # They must define a parser variable
  module Proxy
    # paramaters:
    #   uri         uri of an item
    # returns:
    # => Item, an item with all of the details filled out from the uri
    def parse( uri )
      self.parser.parse(uri)
    end
    # parameters:
    #   string      string to search for 
    # returns:
    # => Array[Item], an array of all items that matched the search string
    def query( string )
      self.parser.query(string)
    end

    # paramaters:
    #   items       list or single item
    # return: 
    # => Array[Fixnum] or Fixnum, a fixnum representing the cost of the item or items
    def price( items )
      self.parser.price(items)
    end

    # parameters:
    #   items     hash, where the keys are the items to be ordered, and the values 
    #               are the amount to order for each item.
    def order( items )
      self.parser.order(items) 
    end
  end
end