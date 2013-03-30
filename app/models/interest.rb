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
end
