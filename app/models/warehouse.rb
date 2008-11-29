class Warehouse
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :nullable => false
  property :parser, Object
  
  def method_missing(method_name, *args)

    extend parser unless parser.nil?

    if self.respond_to?(method_name)
      self.send( method_name, *args)
    else
      super
    end
    
  end

end