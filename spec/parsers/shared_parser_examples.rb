require File.dirname(__FILE__) + "/../spec_helper"

shared_examples_for "a parser with required methods" do
  it "should be able to parse a uri" do
    @parser.should respond_to(:parse)
  end
  
  it "should be able to query a string" do
    @parser.should respond_to(:query)
  end
  
  it "should be able to get the price of an item or items" do
    @parser.should respond_to(:price)
  end
  
  it "should be able to order an item or items" do
    @parser.should respond_to(:order)
  end
end