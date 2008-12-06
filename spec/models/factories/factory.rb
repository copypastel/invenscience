module Factory
  class base
    class << self
      def inherited(child)
        @child = child.new
      end
      
      def [](option = :new, &block)
        model = nil
        
        case option
        when :new:
          model = @child.new_model
        when :valid:
          model = @child.valid_model
        when :saved:
          model = @child.saved_model
        else
          raise NotImplementedError
        end
        
        if block_given?
          yield(model)
        end
        
        model
      end
    end
  end
end