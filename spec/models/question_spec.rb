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
      Question.ask('Run a toy store', 'enterprising')
      expect(Question.first.topic).to eq 'enterprising'
    end
  end
end
