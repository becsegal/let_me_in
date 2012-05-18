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
      auth_hash = request.env['omniauth.auth']
      if params[:provider] == 'identity'
        clear_return_path
        options = {:redirect_url => main_app.post_login_path}
        data = User.find_or_create_by_auth_hash auth_hash
        Rails.logger.debug "user: #{data.inspect}"
        sign_in(data) if data
      else
        Rails.logger.debug "account_types: #{LetMeIn::Engine.config.account_types.inspect}"
        Rails.logger.debug "looking for: #{params[:provider].downcase}"
        provider_class = LetMeIn::Engine.config.account_types
                                        .select{|p| p.name.downcase =~ /#{params[:provider].downcase}/i}[0]
        Rails.logger.debug "provider_class: #{provider_class}"
        data = provider_class.link(auth_hash, current_user)
      end
      render_or_redirect data.serializable_hash, options || {}
    end
    
  end
end