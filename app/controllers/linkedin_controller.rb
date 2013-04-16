class LinkedinController < ApplicationController

  def index
    # get your api keys at https://www.linkedin.com/secure/developer
    client = LinkedIn::Client.new(ENV["LINKEDIN_KEY"], ENV["LINKEDIN_SECRET"])
    if User.where(l_token:session[:atoken]).first.present?
      redirect_to oauth_callback_path
    else
      request_token = client.request_token(:oauth_callback =>
                                        "http://#{request.host_with_port}/oauth/callback")
      session[:rtoken] = request_token.token
      session[:rsecret] = request_token.secret
      redirect_to client.request_token.authorize_url
    end


  end

  def callback
    client = LinkedIn::Client.new(ENV["LINKEDIN_KEY"], ENV["LINKEDIN_SECRET"])
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      client.authorize_from_access(session[:atoken], session[:asecret])
    end

    #All OAUTH DONE.
    @profile = client.profile
    #Find or create!
    user = User.find_or_create_by_l_token(l_token:session[:atoken],l_secret:session[:asecret],first:@profile[:first_name],last:@profile[:last_name],password:"a",password_confirmation:"a")
    user.interest = Interest.create
    user.save
    ### LOGIN ###
    if user.present?
      session[:user_id] = user.id
    else
      session[:user_id] = nil
    end
    redirect_to root_path
  end

end
