require File.join( File.dirname(__FILE__), 'factory' )

module Factory
  class Parser < Base
    
    def initialize
    end
    def new_model
    end
    
    def valid_model
      ::Parser::Generic
    end
    
    def saved_model
    end
  end
end