# == Schema Information
#
# Table name: zones
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  education  :text
#  experience :text
#  training   :text
#  career_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Zone < ActiveRecord::Base
  attr_accessible :title,:education,:experience,:training
  has_one :career
end
