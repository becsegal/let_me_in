module LetMeIn
  class Engine < Rails::Engine
    #isolate_namespace LetMeIn
    
    config.autoload_paths << File.expand_path("../app/models/linked_account", __FILE__)
    paths["app/views"] << "app/assets/templates/let_me_in"
    
    self.config.linked_account_classes = []
    
    
    def linked_account_class (klass)
      Rails.logger.debug "Adding class #{klass}"
      if !klass.is_a?(Class)
        begin
          klass = klass.to_s.constantize
        rescue NameError
          raise LoadError, "Could not find matching linked account class for #{klass.inspect}."
        end
      end
      self.config.linked_account_classes << klass
    end
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
