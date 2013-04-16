class MeetupsController < ApplicationController

  def get_meetups
      topic = Career.find(params[:careerid]).trend.industries.split(' ').first
      location = @auth.location.split(' ').join()
      #@user.careers.last.title.split(' ').first
      url = "https://api.meetup.com/find/groups?key=3141755d2b143b6963614c186b75c5d&sign=true&text=#{topic}&page=10"
      @response = HTTParty.get(url)
  end

end