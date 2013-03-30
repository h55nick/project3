class CareersController < ApplicationController
  def index
    @careers = Career.all
    @start = 0
  end

  def show
    @career = Career.find(params[:id])
  end

  def zone_filter
    # NEED ZONES TO CONNECT TO MULTIPLE CAREERS OTHERWISE THIS WILL SUCK
    # zone = "Job Zone One: Little or No Preparation Needed"
    # @careers = Career.where( zone:  )
  end

end