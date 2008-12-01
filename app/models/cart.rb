class Cart
  include DataMapper::Resource
  
  property :id, Serial
  property :cookie, Object

  belongs_to :order
  belongs_to :warehouse
  has n, :details
  has n, :items, :through => :details

  # For debugging purposes at the moment
  def debug
    a = WWW::Mechanize.new {|ag| ag.user_agent_alias = 'Mac Safari'}
    a.cookie_jar = self.cookie
    File.open("temp.html", "w+") << a.get("http://www.sparkfun.com/commerce/shopping_cart.php").body
  end
end
