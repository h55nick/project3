class Meetup
  attr_accessor :client

def intialize
  RMeetup::Client.api_key = ENV['MEETUP_KEY']
  @client = RMeetup::Client
end

def self.search()
end

end