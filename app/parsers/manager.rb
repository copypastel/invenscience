module Parser
  # This is to be included by a model wishing to have parsers
  # attached to them.
  module Manager
    def self.included(manager)
      manager.extend ClassMethods
    end

    def attribute_set(name, value)
      result = super(name,value)
      if name == :parser and attribute_dirty?(:parser) 
        # *Need to figure out how to unextend previous parser!
        # *Luckily the method used is the latest module extended 
        extend self.parser if not self.parser.nil?
      end
      result
    end

    module ClassMethods
      # Handles when an object is retrieved from the database
      def load(values, query)
        manager = super(values,query)
        manager.extend manager.parser unless manager.parser.nil?
        manager
      end        
    end

  end
end