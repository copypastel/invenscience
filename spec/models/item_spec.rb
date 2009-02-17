require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', 'factories', 'item_factory')

describe Item do

  describe "when valid" do
    before(:each) do
      @item = SpecFactory::Item.gen(:saved)
    end

    it "should have a unique name" do
      copy = SpecFactory::Item.gen(:valid) do |model| 
        model.name = @item.name 
      end
        
      copy.should_not be_valid
    end
      
  end
end