require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', "factories", 'base' )

describe Project do

  describe "when valid" do
    before(:each) do
      @project = SpecFactory.gen(Project,:valid)
    end
    
    it "must have a name" do
      @project.name = nil
      @project.should_not be_valid
    end
  end
  
end