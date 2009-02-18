require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', 'factories', 'base_item_factory')

describe BaseItem do

  describe "when valid" do
    before(:each) do
      @base_item = SpecFactory::BaseItem.gen(:saved)
    end

    it "should have a unique name" do
      copy = SpecFactory::BaseItem.gen(:valid) do |model| 
        model.name = @base_item.name 
      end
        
      copy.should_not be_valid
    end
      
  end

end