require File.join( File.dirname(__FILE__), 'base')
load_factory('base_item')

module SpecFactory
  
  class Item < Base
    
    def initialize
      @new = true
    end
    
    def new_model(count)
      clear_database if @new
      ::Item.new
    end
    
    def valid_model(count)
      clear_database if @new
      ::Item.new(:base_item_id => SpecFactory::BaseItem.gen(:saved).id)
    end
    
    def saved_model(count)
      clear_database if @new
      ::Item.first || (valid_model.save) ? ::Item.first : nil
    end
    
    private
    
    def clear_database
      @new = false
      ::Item.all.each { |i| i.destroy}
    end
    
  end
    
end

describe SpecFactory::Item do
  it "should #gen one new model when no count is given" do
    item = SpecFactory::Item.gen(:new)
    item.should be_new_record
  end
  
=begin it "should #gen multiple new models when a count is given" do
    item1, item2 = SpecFactory::Item.gen(:new,2)
    item1.should be_new_record
    item2.should be_new_record
=end
  
  it "should #gen one valid model when no count is given" do
    item = SpecFactory::Item.gen(:valid)
    item.should be_valid
  end
  
=begin it "should #gen multiple new models when a count is given" do
    item1, item2 = SpecFactory::item.gen(:valid,2)
    item1.should be_valid
    item2.should be_valid
=end
  
  it "should #gen one saved model when no count is given" do
    item = SpecFactory::Item.gen(:saved)
    puts ::Item.first.base_item_id.to_s
    (::Item.first).should be_valid
    item.should be_valid
    item.should_not be_new_record
  end
  
  it "should #gen the same saved model each time" do
    item1 = SpecFactory::Item.gen(:saved)
    item2 = SpecFactory::Item.gen(:saved)
    
    item1.id.should eql(item2.id) 
  end
end