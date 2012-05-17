
module LetMeIn
  class Engine < Rails::Engine
    paths["app/views"] << "app/assets/templates/let_me_in"
    config.autoload_paths << dir = File.expand_path("../linked_accounts", __FILE__)
    Dir[File.join(dir, "*.rb")].each { |l| require l }
    config.autoload_paths << dir = File.expand_path("../core_ext", __FILE__)
    Dir[File.join(dir, "*.rb")].each { |l| require l }
    config.account_types = []
  end
  
  # hack from http://tumblr.teamon.eu/post/898063470/better-scoped-rails-engines-routing
  # b/c I couldn't get named routes working without the isolated namespace
  module Routes
    def self.draw(map)
      map.instance_exec do
        match '/signin' => 'sessions#new', :as => 'signin', :via => :get
        match '/signout' => 'sessions#destroy'

        match '/auth/:provider/connect' => 'auth#connect', :via => :get, :as => 'auth_connect'
        match '/auth/:provider/disconnect' => 'auth#disconnect', :as => 'auth_disconnect'
        match '/auth/:provider/callback' => 'auth#callback', :as => 'auth_callback'
        match '/auth(/:provider)/failure(.format)' => 'auth#failure', :as => 'auth_failure'

        match '/accounts' => 'linked_accounts#index'
      end
    end
  end
end
