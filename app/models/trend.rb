# == Schema Information
#
# Table name: trends
#
#  id         :integer          not null, primary key
#  wages      :string(255)
#  growth     :string(255)
#  openings   :string(255)
#  industries :string(255)
#  career_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Trend < ActiveRecord::Base
  attr_accessible :wages, :growth, :openings,:industries,:career_id
  has_one :career
end
