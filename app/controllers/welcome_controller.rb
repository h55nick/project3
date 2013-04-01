class WelcomeController < ApplicationController
  before_filter :logged_in, only: [:survey, :answer, :simple]
  before_filter :survey_completed, only: [:survey, :answer]
  before_filter :auth_redirect, only:[:index]
  layout 'survey_layout', only: [:survey]

  def index
  end

  def simple
  end

  def survey
    @questions = Question.all.shuffle - @auth.questions
  end

  def answer
    question = Question.find( params[:question_id].to_i )
    Question.up_score(@auth, question.topic, params[:question_val].to_i )
    @auth.questions << question
    @next_question = params[:survey_id][1..-1].to_i + 1
  end
end