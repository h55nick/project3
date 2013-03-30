class CareersController < ApplicationController
  def index
    @careers = Career.all
    @start = 0
  end

  def show
    @career = Career.find(params[:id])
  end

  def zone_filter
    # NEED ZONES TO CONNECT TO MULTIPLE CAREERS OTHERWISE THIS WILL SUCK
    # zone = "Job Zone One: Little or No Preparation Needed"
    # @careers = Career.where( zone:  )
  end



def test_search
  @careers = @auth ? @auth.get_top_careers(5) : Career.all[1..10]
  render :search
end

def search_jobs
    c = Career.find(params[:id])
    url =[]
    qp = c.title
    location = "new york, NYC"
    limit = "100"
    url << "http://api.indeed.com/ads/apisearch?publisher=6311669519978301"
    url << "&q="+ qp
    url <<  "&l=" + location
    url << "&format=json"
    url << "&radius="
    url << "&limit="+ limit
    url << "&co=us"
    url << "&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2"
    @response = HTTParty.get(URI.escape(url.join()))
end
end