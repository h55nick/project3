class Trend < ActiveRecord::Base
  attr_accessible :wages, :growth, :openings,:industries,:career_id
  has_one :career
end