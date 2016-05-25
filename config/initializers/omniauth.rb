require File.expand_path('lib/omniauth/strategies/id', Rails.root)

 Rails.application.config.middleware.use OmniAuth::Builder do
   provider :id, ENV["APPLICATION_ID"], ENV["SECRET"]
 end
