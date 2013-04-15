# == Schema Information
#
# Table name: jobs
#
#  id          :integer          not null, primary key
#  url         :text
#  name        :string(255)
#  description :text
#  company     :string(255)
#  location    :string(255)
#  deadline    :date
#  website     :string(255)
#  lat         :float
#  lon         :float
#  completed   :boolean          default(FALSE)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Job < ActiveRecord::Base
  attr_accessible :company, :completed, :deadline, :description, :lat, :location, :lon, :name, :url, :website
  belongs_to :user
  before_save :geocode

  def self.search(u,c,query = nil)
    url =[]
    if query.nil?
        ## Taking the first two words of the Career Title, and the first word of the top Industry
      query = c.title.gsub('and',"").split(" ")[0..1].join(" ").gsub(",","") +"  " +c.trend.industries.split(' ')[0]
    end
    u.location.nil? ? location = "USA" : location = u.location
    limit = "100"
    url << "http://api.indeed.com/ads/apisearch?publisher=6311669519978301"
    url << "&q="+ query
    url << "&l=" + location
    url << "&format=json"
    url << "&radius="
    url << "&limit="+ limit
    url << "&co=us"
    url << "&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2"
    c = HTTParty.get(URI.escape(url.join()))
  end

  def add_from_idealist(input)
    doc = Nokogiri::HTML(open(input))
    self.name = doc.xpath("//div[@id='contentHeader']/h1").text
    self.company = doc.xpath("//p[@id='listing-sub-title']/a").text
    self.url = input
    self.description = doc.xpath("//div[@id='listing-description']").text.gsub("\t","") + doc.xpath("//div[@id='listing-instructions']").text.gsub("\t","")
    self.location = doc.xpath("//div[@id='box-Location']/div[@class='body']/div[@class='contentGroup']/div[@class='content']/dl/dd").text
    self.save
  end

  def add_from_authentic_jobs(input)
    doc = Nokogiri::HTML(open(input))
    self.name = doc.xpath("//div[@class='role']/h1").text
    self.company = doc.xpath("//hgroup/h2").first.text.gsub(/[\t\n]/,"")
    self.url = input
    self.description = doc.xpath("//div[@class='role']/section[@id = 'description']").text.gsub("\t","")
    self.location = doc.xpath("//a[@id='location']/span").text
    self.website = doc.xpath("//div[@class = 'title ']/a").first.attributes['href'].text
    self.save
  end

  def add_from_indeed(input)
    doc = Nokogiri::HTML(open(input))
    self.name = doc.xpath("//b[@class='jobtitle']").text
    self.company = doc.xpath("//span[@class='company']").text
    self.url = input
    self.description = doc.xpath("//span[@class='summary']").text
    self.location = doc.xpath("//span[@class='location']").text
    self.save
  end

  def transform_to_job(input)
    doc = Nokogiri::HTML(HTTParty.get(input))
    self.name = doc.xpath("//b[@class='jobtitle']").text
    self.company = doc.xpath("//span[@class='company']").first.text
    self.url = input
    self.description = doc.xpath("//span[@class='summary']").text.squish
    self.location = doc.xpath("//span[@class='location']").first.text.squish
    self.save
    self
  end

  def add_from_37signals(input)
    doc = Nokogiri::HTML(open(input))
    self.name = doc.xpath("//div[@class='listing-header-container']/h1").text
    self.company = doc.xpath("//span[@class='company']").text
    self.url = input
    self.description = doc.xpath("//div[@class='listing-container']").text
    self.location = doc.xpath("//span[@class='location']").text.split(': ')[1]
    self.save
  end

  def geocode
    result = Geocoder.search(self.location).first
    if result.present?
      self.lat = result.latitude
      self.lon = result.longitude
    end
  end
end
