Rails.application.config.middleware.use OmniAuth::Builder do
	
	# provider :facebook, ENV["FB_ID"], ENV["FB_SECRET"], :image_size => "large"

	provider :twitter, Rails.application.secrets.twitter_api_key, Rails.application.secrets.twitter_api_secret, 
	{
    :secure_image_url => 'true',
    :image_size => 'original',
    :authorize_params => {
      :force_login => 'true',
      :lang => 'pt'
    }
  }
	# Por si falla twitter

	on_failure { |env| ApplicationController.action(:connect).call(env)}

end