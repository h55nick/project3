# == Schema Information
#
# Table name: interests
#
#  id            :integer          not null, primary key
#  t3            :string(255)
#  social        :integer          default(0)
#  investigative :integer          default(0)
#  realistic     :integer          default(0)
#  enterprising  :integer          default(0)
#  conventional  :integer          default(0)
#  artistic      :integer          default(0)
#  career_id     :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  question_id   :integer
#

class Interest < ActiveRecord::Base
  #Base
  attr_accessible :t3, :social, :investigative, :realistic, :enterprising, :conventional, :artistic

  #Adjunct
  attr_accessible :career_id

  #Relationships
  has_one :career
  has_one :user
  has_one :question

  # SCOPES
  scope :user_interests, where( 'user_id is NOT NULL' )

  def Interest.return_array_of_interests(object)
    [object.interest.realistic,
      object.interest.investigative,
      object.interest.artistic,
      object.interest.social,
      object.interest.enterprising,
      object.interest.conventional]
  end

  def Interest.humanize(array)
    multiplier = (100/array.max.to_f)
    array.map! { |x| x * multiplier }
  end

  def self.definition(interest)
    case interest
        when 'conventional' ; return {adj:"Organizers", descrip:"Conventional people like rules and regulations and emphasize self-control. They like structure and order, and dislike unstructured or unclear work and interpersonal situations."}
        when 'enterprising' ; return {adj:"Persuaders",descrip:"Enterprising people are good talkers, and use this skill to lead or persuade others. They also value reputation, power, money and status, and will usually go after it."}
        when 'realistic' ; return {adj:"Doers",descrip:"Realistic people are usually assertive and competitive, and are interested in activities requiring motor coordination, skill and strength. They like concrete approaches to problem solving, rather than abstract theory."}
        when 'artistic' ; return {adj:"Creators", descrip:"Artistic people are usually creative, open, inventive, original, perceptive, sensitive, independent and emotional. They like to think, organize and understand artistic and cultural areas."}
        when 'social' ; return {adj:"Helpers", descrip:"Social people seem to satisfy their needs in teaching or helping situations. They are different than realistic and investigative types because they are drawn more to seek close relationships with other people."}
        when 'investigative' ; return {adj:"Thinkers",descrip:"Investigative people like to think and observe rather than act, to organize and understand information rather than to persuade. They tend to prefer individual rather than people oriented sactivities."}
    end
  end

end

