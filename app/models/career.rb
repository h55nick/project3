class Career < ActiveRecord::Base
  #Base
  attr_accessible :code,:title,:zone
  #Adjunct.
  attr_accessible :interest_id

  #Relationships (Should reflected in Adjunct)
  has_one :interest
end
