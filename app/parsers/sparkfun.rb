class Parser
  module Sparkfun

    # Remember to implement comparable for items
    def query( item )
      agent = WWW::Mechanize.new
      items = []
      agent.get('http://www.sparkfun.com/commerce/categories.php') do |page|
        results = page.form_with(:name => 'quick_find') do |search|
          search.keywords = search_string
        end.submit

        doc = Hpricot(results.body)

        (doc/"a.product_name").each do |link|
          item = Item.new do |i|
            i.name = link.innerHTML
          end
          items << item
        end
      end
      items
    end

    def order( items )
      raise NotImplemented
    end

    def price( items )
      raise NotImplemented
    end

  end
end