class MeetupsController < ApplicationController

  def get_meetups
    topic = Career.find(params[:careerid]).trend.industries.split(' ').first
    current_user.location ? location = current_user.location.split(' ').join() : location = 'New York, NY'
    #@user.careers.last.title.split(' ').first
    url = "https://api.meetup.com/find/groups?key=3141755d2b143b6963614c186b75c5d&sign=true&text=#{topic}&page=10"
    @response = HTTParty.get(url)
  end

end