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

class Question < ActiveRecord::Base
  attr_accessible :q
  has_and_belongs_to_many :users
  has_one :interest

  def Question.ask(question, interest)
    q = Question.create( q: question)
    q.interest = Interest.create( realistic: 0, investigative: 0, social: 0, artistic: 0, conventional: 0, enterprising: 0)
    Question.up_score(q, interest, 5)
  end

  def Question.up_score(owner, interest, value)
    case interest
    when 'realistic'
      owner.interest.update_attributes( realistic: (owner.interest.realistic + value))
    when 'investigative'
      owner.interest.update_attributes( investigative: (owner.interest.investigative + value))
    when 'social'
      owner.interest.update_attributes( social: (owner.interest.social + value))
    when 'conventional'
      owner.interest.update_attributes( conventional: (owner.interest.conventional + value))
    when 'artistic'
      owner.interest.update_attributes( artistic: (owner.interest.artistic + value))
    when 'enterprising'
      owner.interest.update_attributes( enterprising: (owner.interest.enterprising + value))
    end
    owner.interest.save
    owner.update_attributes( total: (owner.total + 5)) if owner.is_a?(User)
  end

  def topic
    return 'realistic' if self.interest.realistic > 0
    return 'investigative' if self.interest.investigative > 0
    return 'social' if self.interest.social > 0
    return 'conventional' if self.interest.conventional > 0
    return 'artistic' if self.interest.artistic > 0
    return 'enterprising' if self.interest.enterprising > 0
  end
end
