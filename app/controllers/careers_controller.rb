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
    # filters by zone on /careers
    params[:zone] == 'All' ? @careers = Career.all : @careers = Career.where( zone_num: params[:zone] )
    @start = 0
  end

  def mycareers
    @careers = @auth.careers
  end

  # def test_search
  #   @careers = @auth ? @auth.get_top_careers(5) : Career.all[1..5]
  #   render :search
  # end

  def add_career
    # this adds the clicked career to the users careers
    @picked = Career.find( params[:career_id].to_i )
    @auth.careers << @picked
  end

  def remove_career
    # this removes the clicked career to the users careers
    @picked = Career.find( params[:career_id].to_i )
    @auth.careers = @auth.careers - [@picked]
    @auth.save
  end

  def search_jobs
    Job.search(@auth,Career.find(params[:id]))
  end
end
