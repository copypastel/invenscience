module Factory
  #TODO: Make these method names more generic.  I.e new_widget instead of new_model... 
  class Base
    #Class Methods
    class << self
      
      def inherited(child)
        child.class_eval do
          cattr_accessor :instance
          cattr_accessor :subclass
        end
        child.subclass = child
      end      

      def [](option = :new, &block)
        model = nil
        # *At #inherited none of the base class is loaded so no methods can be called.
        #  So it must be done here
        set_instance if instance.nil?
        
        case option
        when :new:
          model = self.instance.new_model
        when :valid:
          model = self.instance.valid_model
        when :saved:
          model = self.instance.saved_model
        end
        
        raise NotImplementedError if model.nil?
        
        if block_given?
          yield(model)
        end
        
        return model
      end
      
      private
      def set_instance
        self.instance = subclass.new
      end

    end
  end
end