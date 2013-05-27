Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin_oauth2, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
end