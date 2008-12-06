require 'factory'
module Factory
  
  class Warehouse < Base

    def new_model
      Warehouse.new
    end
    
    def valid_model
      Warehouse.new(:name => MODEL_NAME,:parser => MODEL_PARSER)
    end
    
    def saved_model
      Warehouse.get(:name => MODEL_NAME) || Warehouse.create(:name => MODEL_NAME, :parer => MODEL_PARSER)
    end
    
    MODEL_NAME = 'Sparkfun'
    MODEL_PARSER = Factory::Parser[:valid]
  end
    
end
