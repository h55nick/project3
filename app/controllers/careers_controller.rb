class CareersController < ApplicationController
  before_filter :authenticate_user!

  def index
     options = {growth: ('4'..'5').to_a,prep:(current_user.edconvert.to_s.."5").to_a}
    @careers = current_user.sort_careers(Career.filter(current_user, options))[0..5]
  end

  def show
    if current_user
      @career = Career.find(params[:id])
      @response = Job.search(current_user,@career)
    else
      redirect_to root_path
    end
  end


  def filter
    options = {growth:params[:growth][:values].split(','),prep:params[:prep][:values].split(',')}
    @careers = current_user.sort_careers(Career.filter(current_user, options))
  end

  def mycareers
    @careers = current_user.careers
  end


  def add_career
    # this adds the clicked career to the users careers
    @picked = Career.find( params[:career_id].to_i )
    current_user.careers << @picked
  end

  def remove_career
    # this removes the clicked career to the users careers
    @picked = Career.find( params[:format].to_i )
    current_user.careers = current_user.careers - [@picked]
    current_user.save
    @user = current_user
  end

  def career_info
    @selected_careers = []
    params[:careers].split(',').each { |id| @selected_careers << Career.find(id) }
  end
end
