Rails.application.config.middleware.use OmniAuth::Builder do
	
	# provider :facebook, ENV["FB_ID"], ENV["FB_SECRET"], :image_size => "large"

	provider :twitter, ENV["TW_ID"], ENV["TW_SECRET"],
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