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
        model.breaks = {1...5 => 10.00, 5...10 => 5.00, 10...infinity => 2.00}
      end
    end 
    
    it "should return the price for the given break" do
      @price_break.price_for(1).should eql(10.00)
      @price_break.price_for(5).should eql(5.00)
      @price_break.price_for(500).should eql(2.00)
    end
    
    it "should add a range when calling #add_break" do
      @price_break.ranges.size.should be(3)
      @price_break.add_break(10...50,3.00).should be(true)
      @price_break.ranges.size.should be(4)
    end
    
    it "should properly add a range by adjusting existing ranges when calling #add_break" do
      @price_break.add_break(10...50,3.00).should be(true)
      @price_break.price_for(  1).should eql(10.00)
      @price_break.price_for(  5).should eql( 5.00)
      @price_break.price_for(500).should eql( 2.00)
      @price_break.price_for( 10).should eql( 3.00)
      @price_break.price_for( 25).should eql( 3.00)
      @price_break.price_for( 50).should eql( 2.00)
    end
    
    it "should return a list of #ranges" do
      @price_break.ranges.size.should be(3)
      @price_break.ranges.include?(1...5).should be(true)
      @price_break.ranges.include?(5...10).should be(true)
      @price_break.ranges.include?(10...1.0/0).should be(true)
    end
    
    it "should remove a range when calling #remove_break" do
      @price_break.ranges.size.should be(3)
      @price_break.remove_break(@price_break.ranges[0]).should be(true)
      @price_break.ranges.size.should be(2)
      @price_break.remove_break(@price_break.ranges[0]).should be(true)
      @price_break.ranges.size.should be(1)
      @price_break.remove_break(@price_break.ranges[0]).should be(true)
      @price_break.ranges.size.should be(1)
      @price_break.ranges.include?(1...1.0/0).should be(true)
    end
    
    it "should properly remove a range when calling #remove_break"# do
  #    pending
  #    @price_break.remove_break(1...5).should be(true)
  #    @price_break.ranges.include?(1...10).should be(true)
  #    @price_break.price_for(1).should be(5)
  #  end
  end
end