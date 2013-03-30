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
  attr_accessible :code,:title,:zone_num, :tasks
  #Adjunct.
  attr_accessible :interest_id

  #Relationships (Should reflected in Adjunct)
  has_and_belongs_to_many :users
  has_one :interest
  has_one :trend
  has_one :zone

  def add_tasks
    self.tasks.present? ? self.task.delete : ""
    url =  'http://www.onetonline.org/' + "link/table/details/tk/"+self.code+"/Tasks_"+self.code+".csv?fmt=csv&amp;s=IM&amp;t=-10"
    tasks = HTTParty.get(url).split(/\r?\n/).map!{|d| d.split(",")[2..-1].join(",")}[1..3].join(" ").gsub(/\"/,'')
    self.tasks = tasks
    self.save
  end

  def add_interests
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
    #career.zone.present? ? career.zone.delete : ""
    onet_base_url =  'http://www.onetonline.org/'
    zonscv = "link/table/details/jz/" + self.code + "/Job_Zone_"+ self.code+"47-5041-00.csv?fmt=csv"
    z = HTTParty.get(onet_base_url  + zonscv).split(/\r?\n/).map!{|d| d.split(",")}
    params ={title:z[1][1],education:z[2][1].gsub(/\"/,''),experience:z[3][1..-1].join(",").gsub(/\"/,''),training:z[4][1..-1].join(',').gsub(/\"/,'')}
    self.zone = Zone.create(params)
    self.save
  end

  def add_trends
    onet_base_url =  'http://www.onetonline.org/'
    trend_url = onet_base_url + "link/details/"+ self.code
    s = Nokogiri::HTML(HTTParty.get(trend_url)).xpath('//table').last.text().split(/\r?\n/)
    params = {wages:s[1].gsub(/\"/,''),growth:s[5..6].join("").gsub(/\"/,''),openings:s[9].gsub(/\"/,''),industries:s[11].gsub(/\"/,'')}
    self.trend = Trend.create(params)
    self.save
  end

end
