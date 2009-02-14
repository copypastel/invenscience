require File.dirname(__FILE__) + "/../spec_helper"
require File.dirname(__FILE__) + '/shared_parser_examples'
class Temp
  include Parser::Proxy
end

describe Parser::Proxy do
  before(:all) do
    @parser = Temp
  end
  
  it_should_behave_like "a parser with required methods"
end

=begin
shared_examples_for "a functioning parser manager" do

  it "should not be able to parse without parser set" do
    @warehouse.parser = nil if @warehouse.parser
    
    lambda { @warehouse.parse(good_uri) }.should raise_error(NoMethodError)
  end

  it "should be able to parse once parser is set" do
    @warehouse.parser = WarehouseSpecHelper::ValidParser1 if @warehouse.parser.nil?
    
    lambda { @warehouse.parse(good_uri) }.should_not raise_error()
    @warehouse.parse(good_uri).should == @warehouse.parser.responce #be(string) does not work
  end
  
  it "should be able to parse once parser is changed" do
    @warehouse.parser = WarehouseSpecHelper::ValidParser1
    @warehouse.parse(good_uri).should == WarehouseSpecHelper::ValidParser1.responce
    
    @warehouse.parser = WarehouseSpecHelper::ValidParser2
    @warehouse.parse(good_uri).should == WarehouseSpecHelper::ValidParser2.responce
  end
  
  it "should not be the original parser when a parser is switched" #do
    @warehouse.parser = WarehouseSpecHelper::ValidParser1
    @warehouse.parser = WarehouseSpecHelper::ValidParser2
    @warehouse.is_a?(WarehouseSpecHelper::ValidParser1).should be(false)
    @warehouse.is_a?(WarehouseSpecHelper::ValidParser2).should be(true)
  end
  
end
=
#A parser in this case has the ability to use included method, ParserSpec has more specifics about parser
shared_examples_for "a functioning parser" do
  it "should be able to parse a uri" do
    @warehouse.parse(good_uri).should == @warehouse.parser.responce
  end
end

describe Parser::Manager do
end
=end
=begin
#A parser manager has the ability to manipulate the different parsers it implements
shared_examples_for "a functioning parser manager" do

  it "should not be able to parse without parser set"# do
    #@warehouse.parser = nil if @warehouse.parser
    
#    lambda { @warehouse.parse(good_uri) }.should raise_error(NoMethodError)
#  end

  it "should be able to parse once parser is set" do
    @warehouse.parser = WarehouseSpecHelper::ValidParser1 if @warehouse.parser.nil?
    
    lambda { @warehouse.parse(good_uri) }.should_not raise_error()
    @warehouse.parse(good_uri).should == @warehouse.parser.responce #be(string) does not work
  end
  
  it "should be able to parse once parser is changed" do
    @warehouse.parser = WarehouseSpecHelper::ValidParser1
    @warehouse.parse(good_uri).should == WarehouseSpecHelper::ValidParser1.responce
    
    @warehouse.parser = WarehouseSpecHelper::ValidParser2
    @warehouse.parse(good_uri).should == WarehouseSpecHelper::ValidParser2.responce
  end
  
  it "should not be the original parser when a parser is switched" #do
  #  @warehouse.parser = WarehouseSpecHelper::ValidParser1
  #  @warehouse.parser = WarehouseSpecHelper::ValidParser2
  #  @warehouse.is_a?(WarehouseSpecHelper::ValidParser1).should be(false)
  #  @warehouse.is_a?(WarehouseSpecHelper::ValidParser2).should be(true)
  #end
  
end

#A parser in this case has the ability to use included method, ParserSpec has more specifics about parser
shared_examples_for "a functioning parser" do
  it "should be able to parse a uri" do
    @warehouse.parse(good_uri).should == @warehouse.parser.responce
  end
end

describe Warehouse do
 # include WarehouseSpecHelper
  
  describe "(virgin)" do
    before(:each) do
      @warehouse = virgin_warehouse
    end
    
   
      
    
    
    
    it "should not have a default parser" do
      lambda { @warehouse.parse(good_uri) }.should raise_error(NoMethodError)
    end
    
    it_should_behave_like "a functioning parser manager"
    
  end
    
  
    
    it_should_behave_like "a functioning parser manager"
  end
  
  
    
    it_should_behave_like "a functioning parser manager"
    it_should_behave_like "a functioning parser"
  end
=end