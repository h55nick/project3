class Job



  def self.search(u,c,query = nil)
    url =[]
    if query.nil?
      query = c.title.gsub('and',"").split(" ")[0..2].join(" ").gsub(",","")
    end
    limit = "100"
    url << "http://api.indeed.com/ads/apisearch?publisher=6311669519978301"
    url << "&q="+ query
    url << "&l=" + u.location
    url << "&format=json"
    url << "&radius="
    url << "&limit="+ limit
    url << "&co=us"
    url << "&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2"
    HTTParty.get(URI.escape(url.join()))
  end
end