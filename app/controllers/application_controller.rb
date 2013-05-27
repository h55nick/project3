class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def survey_completed
    redirect_to(root_path) if current_user && (current_user.questions.length == Question.all.length)
  end

end
