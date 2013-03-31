class WelcomeController < ApplicationController
  # before_filter :logged_in, only: [:survey]
  layout 'survey_layout', only: [:survey]

  def index
  end

  def simple
  end

  def survey
    @question = Question.all.shuffle.first
  end
end