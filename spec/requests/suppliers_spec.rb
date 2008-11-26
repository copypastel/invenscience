require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/suppliers" do
  before(:each) do
    @response = request("/suppliers")
  end
  
  it "should respond to :index" do
    @response.should respond_successfully
  end
  
end