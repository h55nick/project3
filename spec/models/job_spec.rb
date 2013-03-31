# == Schema Information
#
# Table name: jobs
#
#  id          :integer          not null, primary key
#  url         :text
#  name        :string(255)
#  description :text
#  company     :string(255)
#  location    :string(255)
#  deadline    :date
#  website     :string(255)
#  lat         :float
#  lon         :float
#  completed   :boolean          default(FALSE)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Job do
  pending "add some examples to (or delete) #{__FILE__}"
end
