require File.join( File.dirname(__FILE__), '..','spec_helper')

module SpecFactory
  #TODO: Make these method names more generic.  I.e new_widget instead of new_model... 
  #class Base
    @@valid_definitions = {}
    #Class Methods
    class << self
      
      def gen(klass,option,quantity = 1, &block)
        # result will be an aray or a single model depending on the quantity
        result = nil
                
        case option
        when :new:
          result = create_new(klass,quantity)
        when :valid:
          result = create_valid(klass,quantity)
        when :saved:
          result = create_saved(klass,quantity)
        end
        
        if block_given?
          yield(result)
        end
        
        return result
      end
      
      def define_valid(klass, &block)
        definition = ValidDefinition.new(klass)
        yield(definition)
        @@valid_definitions[klass] = definition
      end
      
      private
      
      def create_new(klass, quantity)
        result = []
        quantity.times { |i| result.push(klass.new) }
        result = result.first if quantity == 1
        result
      end
      
      def create_valid(klass, quantity)
        require File.join( File.dirname(__FILE__), '..','models',klass.to_s.snake_case + '_spec') if @@valid_definitions[klass].nil?
        
        attributes = @@valid_definitions[klass].gen_attributes
        
        #puts klass.to_s
        
        result = []
        quantity.times { |i| result.push( klass.new(attributes) ) }
        result = result.first if quantity == 1

        result
      end
      
      def create_saved(klass, quantity)
        result = []
        quantity.times do |i|
          i += 1
          #hack for now... if you delete a record while tests are running index keeps incrementing
          if klass.get(i).nil?
            x = create_valid(klass,1)
            x.save
            result.push x
          else
            result.push klass.get(i)
          end
            
        end
        
        result = result.first if quantity == 1
        result
      end
      
    end
  end
  
  class ValidDefinition
    def initialize(klass)
      @attributes = {}
      @klass = klass
    end
    
    def set(attribute,value,options = {})
      @attributes[attribute] = {:value => value, :options => options }
    end
    
    def gen_attributes
      result = {}
      @attributes.each do |attribute,hash|
        if hash[:options][:unique]
          result[attribute] = hash[:value] + @klass.count.to_s
        else
          result[attribute] = hash[:value]
        end
      end
      result
    end
    
 # end
end
