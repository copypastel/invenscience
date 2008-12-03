require File.join( File.dirname(__FILE__), '..', "spec_helper" )

module WarehouseSpecHelper
  # See parser specs for parser functionality!
  module ValidParser1
    def parse(uri)
      ValidParser1.responce
    end
    
    def self.responce
      "responce 1"
    end
  end
  
  module ValidParser2
    def parse(uri)
      ValidParser2.responce
    end
    
    def self.responce
      "responce 2"
    end
  end
  
  #testing for the uri should go in parser spec
  def good_uri
    "Good URI" #Could switch this to http:// and have a bad_uri for testing
  end
  
  def virgin_warehouse
    Warehouse.new
  end
  
  def valid_warehouse
    warehouse = Warehouse.new
    warehouse.name = "Valid Name"
    warehouse.parser = ValidParser1
    warehouse
  end
  
  def saved_warehouse
    #switch to fixtures!
    warehouse = Warehouse.first 
    if(warehouse.nil?)
      warehouse = valid_warehouse
      warehouse.name = "Original Valid Name"
      warehouse.save
    end
    warehouse
  end
end

shared_examples_for "a new record" do
  it "should be a new record" do
    @warehouse.should be_new_record
  end
end

#A parser manager has the ability to manipulate the different parsers it implements
shared_examples_for "a functioning parser manager" do
  include WarehouseSpecHelper
  
  it "should not be able to parse without parser set"# do
#    @warehouse.parser = nil if @warehouse.parser
    
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
  include WarehouseSpecHelper
  
  describe "(virgin)" do
    before(:each) do
      @warehouse = virgin_warehouse
    end
    
    it_should_behave_like "a new record"
      
    it "should not have default values" do
      @warehouse.name.should    be_nil
      @warehouse.parser.should  be_nil
      @warehouse.id.should      be_nil
    end
    
    it "should not be valid" do
      @warehouse.should_not be_valid
    end
    
    it "should have two errors after valid check" do
      @warehouse.should_not be_valid
      @warehouse.errors.length.should be(2)
    end
    
    it_should_behave_like "a functioning parser manager"
    
  end
    
  describe "(unsaved)" do
    before(:each) do
      @warehouse = valid_warehouse
    end
    
    it_should_behave_like "a new record" 
    
    it "should not be valid without #name" do
      warehouse      = valid_warehouse      
      warehouse.name = nil
      
      warehouse.should_not be_valid
    end
    
    it "should not be valid without #parser" do
      warehouse        = valid_warehouse
      warehouse.parser = nil
      
      warehouse.should_not be_valid
    end
    
    it_should_behave_like "a functioning parser manager"
  end
  
  describe "(before save)" do
    before(:each) do
      @warehouse = valid_warehouse
    end
    
    it "should be valid" do
      @warehouse.should be_valid
    end
    
    it "should have an original name" do
      @warehouse.name = saved_warehouse.name
      @warehouse.should_not be_valid
    end
    
    it_should_behave_like "a functioning parser manager"
    it_should_behave_like "a functioning parser"
  end

  describe "(after save)" do
    before(:each) do
      @warehouse = saved_warehouse
    end
    it "should not be a new record"
    
    it_should_behave_like "a functioning parser manager"
    it_should_behave_like "a functioning parser"
  end

end
