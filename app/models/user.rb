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
    self.total > 25
  end

  def get_top_careers(n = 10)
    vals = self.get_top_interests
    Career.readonly.joins(:interest).order("#{vals[0]} DESC").order("#{vals[1]} DESC").order("#{vals[2]} DESC").limit(n)
  end

  def get_top_interests()
    i = self.interest
    k = {social:i.social,investigative:i.investigative,realistic:i.realistic,enterprising:i.enterprising,conventional:i.conventional,artistic:i.artistic}
    k = k.sort_by { |n, a| a }.reverse.map!{|p| p[0].to_s}
    return k
  end

end
