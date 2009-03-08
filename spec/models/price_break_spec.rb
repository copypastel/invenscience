require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', "factories", 'base' )

describe PriceBreak do
  describe "when saving" do
    before(:each) do
      @price_break = SpecFactory.gen(PriceBreak,:valid)
    end
    
    it "should have a default range after a save if nil" do
      @price_break.breaks.should be_nil
      @price_break.save.should be(true)
      @price_break.breaks.should_not be(nil)
    end
  end
  
  describe "when in operation" do
    before(:each) do
      @price_break = SpecFactory.gen(PriceBreak,:valid) do |model|
        infinity = 1.0/0
        model.breaks = {1..5 => 10.00, 5..10 => 5.00, 10..infinity => 2.00}
      end
    end 
    
    it "should return the price for the given break" do
      @price_break.price_for(1).should eql(10.00)
      @price_break.price_for(5).should eql(5.00)
      @price_break.price_for(500).should eql(2.00)
    end
  end
end