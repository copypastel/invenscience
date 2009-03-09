require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe OrderItem do
  describe "when valid" do
    before(:each) do
      @order_item = SpecFactory.gen(OrderItem,:Valid)
      
      it "must have a #base_item" do
        @order_item.base_item_id = nil
        @order_item.should_not be_valid
      end
    end
  end
end