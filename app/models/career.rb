# == Schema Information
#
# Table name: careers
#
#  id           :integer          not null, primary key
#  code         :string(255)
#  title        :string(255)
#  zone_num     :string(255)
#  zone_id      :integer
#  tool_id      :integer
#  knowledge_id :integer
#  skill_id     :integer
#  ability_id   :integer
#  activity_id  :integer
#  context_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  tasks        :text
#

class Career < ActiveRecord::Base
  #Base
  attr_accessible :code,:title,:zone_num, :tasks,:growth_num
  #Adjunct.
  attr_accessible :interest_id

  #Relationships (Should reflected in Adjunct)
  has_and_belongs_to_many :users
  has_one :interest
  has_one :trend
  has_one :zone

  def annual_salary
    self.trend.wages.match(/\d+\S\d+ annual/).to_s.gsub(",","").to_i
  end

  def get_top_interests(length = 7)
    i = self.interest
    k = {social:i.social,investigative:i.investigative,realistic:i.realistic,enterprising:i.enterprising,conventional:i.conventional,artistic:i.artistic}
    k = k.sort_by { |n, a| a }.reverse.map!{|p| p[0].to_s}
    return k[0..length-1]
end
def self.get_interests_fast(career,i) #this needs to be passed interests with.
    k = {social:i.social,investigative:i.investigative,realistic:i.realistic,enterprising:i.enterprising,conventional:i.conventional,artistic:i.artistic}
    k = k.sort_by { |n, a| a }.reverse.map!{|p| p[0].to_s}
end

  def tr_color
    interest = self.get_top_interests(3)[(rand*3).to_i]
    case interest
    when 'conventional' ; return '#4D5360'
    when 'enterprising' ; return '#FFC629'
    when 'realistic' ; return '#FF2151'
    when 'artistic' ; return '#FF7B29'
    when 'social' ; return '#8B77B5'
    when 'investigative' ; return '#7686C2'
    end
  end

def gconvert
    z = self.trend ? self.trend.growth.split(' ').first.downcase  : "average"
    case z
    when "little"
      return 1
    when "slower"
      return 2
    when "average"
      return 3
    when "faster"
      return 4
    when 'much'
      return 5
    else
      return 3
    end
  end

#######  ADDING FILTER ######
  def self.filter(auth = nil, options  = {})
    Career.readonly.where(:zone_num =>options[:prep],:growth_num=>options[:growth]).limit(100).shuffle
  end


########  DATABASE ADDING  FUNCTIONS ########
  def add_tasks
    self.tasks.present? ? self.tasks = nil : ""
    url =  'http://www.onetonline.org/' + "link/table/details/tk/"+self.code+"/Tasks_"+self.code+".csv?fmt=csv&amp;s=IM&amp;t=-10"
    tasks = HTTParty.get(url)
    tasks = tasks.split(/\r?\n/)
    puts "+ Tasks "
    tasks = tasks.map!{|d| d.split(",").length > 3 ? d.split(",")[2..-1].join(",") : ""}[1..3].join(" ").gsub(/\"/,'')
    self.tasks = tasks
    self.save
  end
  def add_interests
    puts "+ Interests"
    self.interest.present? ? self.interest.delete : ""
    onet_base_url =  'http://www.onetonline.org/'
    intscv = "link/table/details/in/"+ self.code + "/Interests_"+self.code+".csv?fmt=csv&s=OI&t=-10"
    interests = HTTParty.get(onet_base_url  + intscv).split(/\r?\n/).map!{|d| d.split(",")}
    params = {} #make sure params is empty
    interests[1..-1].map{ |i| params[ i[1].downcase] = i[0] } #creating params for intersts create
    self.interest = Interest.create(params)
    self.save #double check the save
  end
  def add_zone
    puts "+ Zone"
    #career.zone.present? ? career.zone.delete : ""
    onet_base_url =  'http://www.onetonline.org/'
    zonscv = "link/table/details/jz/" + self.code + "/Job_Zone_"+ self.code+"47-5041-00.csv?fmt=csv"
    z = HTTParty.get(onet_base_url  + zonscv).split(/\r?\n/).map!{|d| d.split(",")}
    params ={title:z[1][1],education:z[2][1].gsub(/\"/,''),experience:z[3][1..-1].join(",").gsub(/\"/,''),training:z[4][1..-1].join(',').gsub(/\"/,'')}
    self.zone = Zone.create(params)
    self.save
  end
  def add_trends
    puts "+ Trends"
    onet_base_url =  'http://www.onetonline.org/'
    trend_url = onet_base_url + "link/details/"+ self.code
    s = Nokogiri::HTML(HTTParty.get(trend_url)).xpath('//table').last.text().split(/\r?\n/)
    params = {wages:s[1].gsub(/\"/,''),growth:s[5..6].join("").gsub(/\"/,''),openings:s[9].gsub(/\"/,''),industries:s[11].gsub(/\"/,'')}
    self.trend = Trend.create(params)
    self.growth_num = self.gconvert
    self.save
  end

end
