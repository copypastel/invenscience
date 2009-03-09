require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', "factories", 'base' )
require File.join( File.dirname(__FILE__), '..', "shared", 'item_manager_spec' )

describe Order do

  describe "as a item manager" do
     before(:each) do
       @item_manager_class = Order
     end

     it_should_behave_like "an item manager"
   end

end