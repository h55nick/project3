class CareersController < ApplicationController
  before_filter :logged_in

  def index
    @careers = @auth.get_top_careers(50)
    @end = 5
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
  def zone_filter
    @end = 5
    # filters by zone on /careers
    zone = params[:zone]
    zone == 'All' ? @careers = @auth.get_top_careers(@end): @careers = @auth.get_top_careers(@end+900).reject {|d| d.zone_num != zone.to_s}
    @start = 0 #for knowing where to start
    @zone = params[:zone] #for updating more button
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

  def career_info
    @selected_careers = []
    params[:careers].split(',').each { |id| @selected_careers << Career.find(id) }
  end
end
