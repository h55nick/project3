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
      owner.interest.realistic += value
    when 'investigative'
      owner.interest.investigative += value
    when 'social'
      owner.interest.social += value
    when 'conventional'
      owner.interest.conventional += value
    when 'artistic'
      owner.interest.artistic += value
    when 'enterprising'
      owner.interest.enterprising += value
    end
    owner.interest.save
  end

  def topic
    return 'realistic' if self.interest.realistic.present?
    return 'investigative' if self.interest.investigative.present?
    return 'social' if self.interest.social.present?
    return 'conventional' if self.interest.conventional.present?
    return 'artistic' if self.interest.artistic.present?
    return 'enterprising' if self.interest.enterprising.present?
  end
end
