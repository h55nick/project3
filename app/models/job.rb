class Job



  def self.search(u,c,query = nil)
    url =[]
    if query.nil?
        ## Taking the first two words of the Career Title, and the first word of the top Industry
      query = c.title.gsub('and',"").split(" ")[0..1].join(" ").gsub(",","") +"  " +c.trend.industries.split(' ')[0]
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