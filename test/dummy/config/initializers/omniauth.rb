

Rails.application.config.middleware.use OmniAuth::Builder do
  if Banters.available?
    provider :banters, Banters.key, Banters.secret 
  end
  
  if LetMeIn::Instagram.available?
    provider :instagram, LetMeIn::Instagram.key, LetMeIn::Instagram.secret, :display => 'touch'
  end
  
  if LetMeIn::Twitter.available?
    provider :twitter, LetMeIn::Twitter.key, LetMeIn::Twitter.secret 
  end
  
  provider :identity, :fields => [:username, :email], :model => LetMeIn::User, 
    :on_failed_registration => lambda { |env| 
      AuthController.action(:failure).call(env) 
    }
end
