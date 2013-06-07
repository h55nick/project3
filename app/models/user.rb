# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first                  :string(255)
#  last                   :string(255)
#  password_digest        :string(255)
#  location               :string(255)
#  education              :string(255)
#  lat                    :integer
#  lon                    :integer
#  interest_id            :integer
#  total                  :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  l_token                :string(255)
#  l_secret               :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  authentication_token   :string(255)
#  email                  :string(255)      default(""), not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  ##########################################
  # ACCESSIBLE ATTRIBUTES
  ##########################################

  attr_accessible :education, :first, :last, :lat, :location, :lon, :total
  attr_accessible :l_token, :l_secret

  ##########################################
  # RELATIONS
  ##########################################

  has_and_belongs_to_many :questions
  has_and_belongs_to_many :careers
  has_many :jobs
  has_one :interest

  ##########################################
  # BEFORE SAVE
  ##########################################

  before_save :geocode
  before_save :t3_save

  ##########################################
  # DEVISE
  ##########################################

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  ##########################################
  # ADDITIONAL METHODS
  ##########################################

  def geocode
    result = Geocoder.search(self.location).first
    if result.present?
      self.lat = result.latitude
      self.lon = result.longitude
    end
  end

  def t3_save
    if self.interest
      self.interest.t3 = self.get_top_interests(3).map(&:capitalize).join(', ')
      self.interest.save
    end
  end

  def finished_all_questions
    self.questions.count == Question.all.count
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


  def edconvert
    z = self.education
    case z
    when "little" ; return 1
    when "slower" ; return 2
    when "average" ; return 3
    when "faster" ; return 4
    when 'much' ; return 5
    else ; return 3
    end
  end

  def sort_careers(careers, n = careers.length)
    set = []
    i = self.interest
    myinterest = {social:i.social,investigative:i.investigative,realistic:i.realistic,enterprising:i.enterprising,conventional:i.conventional,artistic:i.artistic}
    careers.uniq! {|d| d.title}.each do |career|
       i = career.interest
       k = {social:i.social,investigative:i.investigative,realistic:i.realistic,enterprising:i.enterprising,conventional:i.conventional,artistic:i.artistic}
       answer = k.map { |key, value| (value - 5 * myinterest[key]).abs}.inject(&:+) #With a + you want the reverse because the distance between the two is a bad thing.
       set << [career,answer]
    end
    set = set.sort_by(&:last).map!{|a| a[0]}#here is were we reverse it and get rid of the num.
  end

  def get_top_interests(n = 0)
    i = self.interest
    k = {social:i.social,investigative:i.investigative,realistic:i.realistic,enterprising:i.enterprising,conventional:i.conventional,artistic:i.artistic}
    k = k.sort_by { |n, a| -a }.map!{|p| p[0].to_s}
    return k[0..(n-1)]
  end

end
