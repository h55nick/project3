# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first           :string(255)
#  last            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  location        :string(255)
#  education       :string(255)
#  lat             :integer
#  lon             :integer
#  interest_id     :integer
#  total           :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :education, :email, :first, :last, :lat, :location, :lon, :password, :password_confirmation, :total
  has_and_belongs_to_many :questions
  has_and_belongs_to_many :careers
  has_many :jobs
  has_one :interest

  before_save :geocode
  def geocode
    result = Geocoder.search(self.location).first
    if result.present?
      self.lat = result.latitude
      self.lon = result.longitude
    end
  end

  def ready_for_graph
    self.total >= 50
  end

  def show_color(interest)
    if self.get_top_interests.include?(interest)
      case interest
      when 'conventional' ; return '#4D5360'
      when 'enterprising' ; return '#FFC629'
      when 'realistic' ; return '#FF2151'
      when 'artistic' ; return '#FF7B29'
      when 'social' ; return '#8B77B5'
      when 'investigative' ; return '#7686C2'
      end
    else
      '#EFEFEF'
    end
  end

  def get_top_careers(n = 10)
    set = []
    c = Career.readonly.joins(:interest).to_a.uniq
    i= self.interest
    myinterest = {social:i.social,investigative:i.investigative,realistic:i.realistic,enterprising:i.enterprising,conventional:i.conventional,artistic:i.artistic}
    c.each do |career|
     i = career.interest
     k = {social:i.social,investigative:i.investigative,realistic:i.realistic,enterprising:i.enterprising,conventional:i.conventional,artistic:i.artistic}
    answer = k.map { |key, value| (value - myinterest[key]).abs}.inject(&:+) #With a + you want the reverse because the distance between the two is a bad thing.
     set << [career,answer]
    end
    set = set.sort_by(&:last).map!{|a| a[0]}#here is were we reverse it
    set = set.uniq! {|d| d.title}[0..(n-1)]
  end

  def get_top_interests()
    i = self.interest
    k = {social:i.social,investigative:i.investigative,realistic:i.realistic,enterprising:i.enterprising,conventional:i.conventional,artistic:i.artistic}
    k = k.sort_by { |n, a| a }.reverse.map!{|p| p[0].to_s}
    return k
  end

end
