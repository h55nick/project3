class WelcomeController < ApplicationController
  before_filter :survey_completed, only: [:survey, :answer]
  before_filter :go_to_show_page, only: [:index]

  def index
    render layout: 'splash'
  end

  def simple
  end

  def survey
    @questions = Question.all.shuffle - @auth.questions
    render layout: 'survey_layout'
  end

  def answer
    if params[:question_id] != '0'
      question = Question.find( params[:question_id].to_i )
      Question.up_score(@auth, question.topic, params[:question_val].to_i )
      @auth.questions << question
    end
    @next_question = params[:survey_id][1..-1].to_i + 1
  end

  private
  def go_to_show_page
    redirect_to(@auth) if @auth
  end
end