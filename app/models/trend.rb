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
  attr_accessible :wages, :growth, :growth_num, :openings,:industries,:career_id
  has_one :career
  before_save :gconvert

  def gconvert
      z = self.growth.split(' ').first.downcase
    case z
      when "little"
        self.growth_num = 1
      when "slower"
        self.growth_num = 2
      when "average"
        self.growth_num = 3
      when "faster"
        self.growth_num = 4
      when 'much'
        self.growth_num = 5
      else
        self.growth_num = 3
    end
  end
end
