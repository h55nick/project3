class Interest < ActiveRecord::Base
  #Base
  attr_accessible :t3, :social,:investigative,:realistic,:enterprising,:conventional,:artistic

  #Adjunct
  attr_accessible :career_id

  #Relationships
  has_one :career
end
