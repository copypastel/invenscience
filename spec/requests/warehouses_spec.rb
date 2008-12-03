require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')
=begin

describe "/warehouses" do
  before(:each) do
    @response = request("/warehouses")
  end
  
  it "should respond to :index" do
    @response.should respond_successfully
  end

end

=end