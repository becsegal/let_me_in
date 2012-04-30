
Rails.application.config.middleware.use OmniAuth::Builder do
  if Banters.available?
    provider :banters, Banters.key, Banters.secret, :name => "banters" 
  end
  
  if Instagram.available?
    provider :instagram, Instagram.key, Instagram.secret, :display => 'touch', :name => "instagram"
  end
  
  if Twitter.available?
    provider :twitter, Twitter.key, Twitter.secret, :name => "twitter"
  end
  
  provider :identity, :fields => [:username, :email], :model => User, 
    :on_failed_registration => lambda { |env| 
      AuthController.action(:failure).call(env) 
    }
end
