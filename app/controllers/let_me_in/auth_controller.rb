module LetMeIn
  class AuthController < ApplicationController
    
    before_filter :authenticate, :except => [:failure, :callback]
    
    def connect
      redirect_to "/auth/#{params[:provider].downcase}"
    end

    def disconnect
      account = current_user.linked_accounts.find(params[:id])
      account.unlink
      render_or_redirect nil, :redirect_url => accounts_path
    end

    def failure
      options = {:status => :bad_request}
      if env['omniauth.identity']
        @identity = env['omniauth.identity']
        result = {:error => pretty_errors(@identity.errors)} if @identity
        options.merge(:redirect_url => let_me_in.signin_path)
      else
        result = {:error => "Unable to connect to your account."}
      end
      render_or_redirect result, options
    end

    def callback
      Rails.logger.debug "callback"
      auth_hash = request.env['omniauth.auth']
      Rails.logger.debug "auth_hash: #{auth_hash.inspect}"
      if params[:provider] == 'identity'
        options = {:redirect_url => main_app.root_path}
        data = User.find_or_create_by_auth_hash auth_hash
        sign_in(data) if data
      else
        provider_class = LetMeIn::Engine.config.linked_account_class_names
                                        .select{|p| p =~ /#{params[:provider]}/i}[0]
        logger.debug "Provider class: #{provider_class}"
        data = "#{provider_class}".constantize.link(auth_hash, current_user)
      end
      render_or_redirect data, options || {}
    end
    
  end
end