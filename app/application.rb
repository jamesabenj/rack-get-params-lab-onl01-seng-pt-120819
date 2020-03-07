class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)



    if req.path.match(/cart/)
      @@cart.each do |item|
        resp.write "#{item}\n"
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Your cart is empty"
    end

    if req.path.match(/add/)
      item = getParam(item)
      @@items.each do |i|
        if i == item
        @@cart << item
        resp.write "added #{item}"
        else
        resp.write "We don't have that item"
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
