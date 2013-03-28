class Zone < ActiveRecord::Base
  attr_accessible :title,:education,:experience,:training
  has_one :career
end