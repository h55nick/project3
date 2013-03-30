# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  q           :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  interest_id :integer
#

require 'spec_helper'

describe Question do
  describe '.ask' do
    it 'should associate and create a question on demand, with the correct interests selected' do
      Question.ask('Run a toy store', 'enterprising')
      expect(Question.first.id).to_not be nil
      expect(Question.first.interest.enterprising).to eq 5
    end
  end

  describe '.topic' do
    it 'should print the full name of the attribute assigned to the question' do
      Question.ask('just x', 'enterprising')
      expect(Question.where( q: 'just x').first.topic).to eq 'enterprising'
    end
  end

  describe 'Question.up_score' do
    it 'should work with users to update their score' do
      user = User.create( email: 'x', password: 'x', password_confirmation: 'x', first: 'Bryan', last: 'Reid', education: "Bachelor's Degree", location: 'New York, NY', total: 0 )
      user.interest = Interest.create( realistic: 0, investigative: 0, social: 0, artistic: 0, conventional: 0, enterprising: 0)
      Question.up_score(user, 'social', 4)
      expect(user.interest.social).to eq 4
      expect(user.total).to eq 5
    end
  end
end
