class CareersController < ApplicationController
  before_filter :logged_in

  def index
    # options = {growth: ('1'..'5').to_a,prep:(@auth.edconvert.to_s.."5").to_a}
    # @careers = @auth.sort_careers(Career.filter(@auth, options))
  end

  def show
    if @auth
      @career = Career.find(params[:id])
      @response = Job.search(@auth,@career)
    else
      redirect_to root_path
    end
  end

  def more
    #gets more careers
      zone = params[:zone]
      @start = params[:start].to_i
      @end = @start+10
      if zone == "0"
        @careers = @auth.get_top_careers(@end+100)
      else
        @careers = @auth.get_top_careers(@end+900).reject {|d| d.zone_num != zone.to_s}
        #Career.where(:zone_num => zone.to_s)[0..@end]
      end
  end
  def filter
    options = {growth:params[:growth][:values].split(','),prep:params[:prep][:values].split(',')}
   @careers = @auth.sort_careers(Career.filter(@auth, options))
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
    @picked = Career.find( params[:format].to_i )
    @auth.careers = @auth.careers - [@picked]
    @auth.save
    @user = @auth
  end

  def career_info
    @selected_careers = []
    params[:careers].split(',').each { |id| @selected_careers << Career.find(id) }
  end
end
