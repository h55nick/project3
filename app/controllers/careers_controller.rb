class CareersController < ApplicationController
  def index
    @careers = Career.all
    @start = 0
  end

  def show
    if @auth
      @career = Career.find(params[:id])
      @response = Job.search(@auth,@career)
    else
      redirect_to root_path
    end
  end

  def zone_filter
    # NEED ZONES TO CONNECT TO MULTIPLE CAREERS OTHERWISE THIS WILL SUCK
    @careers = Career.where( zone_num: "1" )
  end

  def mycareers
    @careers = @auth.careers
  end

  # def test_search
  #   @careers = @auth ? @auth.get_top_careers(5) : Career.all[1..5]
  #   render :search
  # end

  def search_jobs
    Job.search(@auth,Career.find(params[:id]))
  end
end
