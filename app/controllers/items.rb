class Items < Application

  # ...and remember, everything returned from an action
  # goes to the client...
  def index
    render
  end
  
  def new
    render
  end
  
  def create( name )
    item = Item.create( :name => name )
    render
  end
  
end
