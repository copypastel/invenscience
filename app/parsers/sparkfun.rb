module Parser
  module Sparkfun

    @@url_regex = /.*sparkfun.com\/.*/
    @@user_agent = 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_5; en-us) AppleWebKit/525.26.2 (KHTML, like Gecko) Version/3.2 Safari/525.26.12'

    # Remember to implement comparable for items

    def order( items )
      raise NotImplemented
    end

    def price( item, quantity = nil )
      page = Hpricot(open(item.uri, 'User-Agent' => @@user_agent))
      prices = {}
      prices[1..9] = page.at('#price_content > form > table > tr:nth(2) > th').inner_html[1..-1].to_f
      prices[10..99] = page.at('#price_content > form > table > tr:nth(3) > th').inner_html[1..-1].to_f
      prices[100..1/0.0] = page.at('#price_content > form > table > tr:nth(4) > th').inner_html[1..-1].to_f
      if quantity.nil?
        return prices
      else
        (prices.select {|key, value| key.include? quantity })[0][1]
      end
    end


    # Returns item parsed from the uri parameter
    def parse(uri)
      unless parsable?(uri)
        return nil
      else
        page = Hpricot(open(uri, 'User-Agent' => @@user_agent))
        name = page.at('h2.product_name').inner_html
        stock = page.at("table.pricing td").inner_html.split(' ').first.to_i
        return Item.new(:warehouse => self, :name => name, :uri => uri, :stock => stock)
      end
    end

    def parsable?(url)
      (url =~ @@url_regex).nil? ? false : true
    end

  end
end