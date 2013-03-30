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

require 'spec_helper'

describe Question do
  describe '.ready_for_graph' do
    it 'should return true only if all questions have answered at least 30 points worth of questions' do
      user = User.create( email: 'x', password: 'x', password_confirmation: 'x', first: 'Bryan', last: 'Reid', education: "Bachelor's Degree", location: 'New York, NY' )
      user.interest = Interest.create
      expect(user.ready_for_graph).to be false
      user.update_attributes( total: 35 )
      expect(user.ready_for_graph).to be true
    end
  end
end
