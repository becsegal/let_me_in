# Failed idenity login was showing a Rails error page, not redirecting to /auth/identity/failure
# https://github.com/intridea/omniauth-identity/issues/25
# Hack fix from: http://inside.oib.com/getting-more-information-from-omniauth-exceptions/
OmniAuth.config.on_failure do |env|
  exception = env['omniauth.error']
  error_type = env['omniauth.error.type']
  strategy = env['omniauth.error.strategy']
  
  new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{error_type}"
  
  [302, {'Location' => new_path, 'Content-Type'=> 'text/html'}, []]
end


Rails.application.config.middleware.use OmniAuth::Builder do
  if Banters.available?
    provider :banters, Banters.key, Banters.secret, :name => "banters" 
    LetMeIn::Engine.config.account_types << Banters
  end
  
  if Instagram.available?
    provider :instagram, Instagram.key, Instagram.secret, :display => 'touch', :name => "instagram"
    LetMeIn::Engine.config.account_types << Instagram
  end
  
  if Twitter.available?
    provider :twitter, Twitter.key, Twitter.secret, :name => "twitter"
    LetMeIn::Engine.config.account_types << Twitter
  end

  provider :identity, :fields => [:username, :email], :model => User, 
    :on_failed_registration => lambda { |env| 
      AuthController.action(:failure).call(env) 
    }
end

OmniAuth.config.logger = Rails.logger