require File.join( File.dirname(__FILE__), 'factory' )
require File.join( File.dirname(__FILE__), 'parser_factory' )

#You have to be EXTREEMLY careful with scope... Maybe need to add WarehouseFactory in
module Factory
  
  class Warehouse < Base

    MODEL_NAME = 'Sparkfun'
    MODEL_PARSER = Factory::Parser[:valid]
    
    def initialize
      @new = true
    end
    
    def new()
    end
    
    def new_model
      clear_database if @new
      ::Warehouse.new
    end
    
    def valid_model
      clear_database if @new
      ::Warehouse.new(:name => MODEL_NAME + ::Warehouse.count.to_s,:parser => MODEL_PARSER)
    end
    
    def saved_model
      clear_database if @new
      ::Warehouse.first(:name => MODEL_NAME) || ::Warehouse.create(:name => MODEL_NAME, :parser => MODEL_PARSER)
    end
    
    private
    
    def clear_database
      @new = false
      ::Warehouse.all.each { |w| w.destroy}
    end
    
  end
    
end
