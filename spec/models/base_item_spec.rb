require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', "factories", 'base' )

describe BaseItem do

  describe "when valid" do
    before(:each) do
      @base_item = SpecFactory.gen(BaseItem, :valid)
    end

    it "should have a unique name" do
      saved = SpecFactory.gen(BaseItem, :saved)
      
      @base_item.name = saved.name
      @base_item.should_not be_valid
    end
    
    it "must have a #name" do
      @base_item.name = nil
      @base_item.should_not be_valid
    end
      
  end

end