class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    route("/cart") do 
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    end
    if req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Your cart is empty"
    end

    if req.path.match(/add/)
      @@items.each do |i|
        @@cart << i
        resp.write "added #{i}"
      end
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

end
