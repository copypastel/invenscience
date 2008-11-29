class Parser
  module Generic

    # parameters:
    #   string      string to search for 
    # returns:
    #   Array[Item] an array of all items that matched the search string
    def query( string )
      raise NotImplemented
    end

    # return the price for the given item
    # return nil if item can't be found at the warehouse
    def price( items )
      raise NotImplemented    
    end

    # parameters:
    #   items     hash, where the keys are the items to be ordered, and the values 
    #               are the amount to order for each item.
    def order(items = [])
      raise NotImplemented    
    end

  end
end