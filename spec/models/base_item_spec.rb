require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', "factories", 'base' )
#load_factory('base_item')

SpecFactory.define_valid BaseItem do |b|
  b.set :name, 'Toothbrush', :unique => true
end

describe BaseItem do

  describe "when valid" do
    before(:each) do
      @base_item = SpecFactory.gen(BaseItem, :saved)
    end

    it "should have a unique name" do
      copy = SpecFactory.gen(BaseItem, :valid) do |model| 
        model.name = @base_item.name 
      end
        
      copy.should_not be_valid
    end
      
  end

end