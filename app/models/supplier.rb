class Supplier
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :nullable => false
  property :type, Discriminator
#  property :parser, Object, :default => Supplier::DEFAULT_PARSER
  

  # Prepares the supplier object by mixing in the methods
  # provided by its parser to perform search/ordering
=begin
  def prepare
    class << self
      begin
        include self.parser
      rescue NoMethodError
        include Supplier::DEFAULT_PARSER
      end
    end
  end
=end

end