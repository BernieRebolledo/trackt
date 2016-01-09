Rails.application.config.middleware.use OmniAuth::Builder do
	
	provider :twitter, ENV["TW_ID"], ENV["TW_SECRET"], 
	{
	:image_size => 'original'
	}
	# Por si falla twitter

	on_failure { |env| ApplicationController.action(:connect).call(env)}

end