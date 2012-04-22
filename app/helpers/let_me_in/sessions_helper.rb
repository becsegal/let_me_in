module LetMeIn
  module SessionsHelper

    def sign_in(user)
      cookies.permanent.signed[:remember_token] = [user.id, user.auth_token]
      self.current_user = user
    end

    def signed_in?
      !current_user.nil?
    end

    def sign_out
      cookies.delete(:remember_token)
      self.current_user = nil
    end

    def current_user=(user)
      @current_user = user
    end

    def current_user
      @current_user ||= user_from_remember_token
    end

    def authenticate
      deny_access unless signed_in?
    end

    def deny_access
      save_return_path
      render_or_redirect({}, :status => :unauthorized, :redirect_url => signin_path)
    end

    def save_return_path
      cookies[:return_to] = request.fullpath
    end

    def clear_return_path
      cookies.delete(:return_to)
    end


    private

      def user_from_remember_token
        User.authenticate_with_token(*remember_token)
      end

      def remember_token
        cookies.signed[:remember_token] || [nil, nil]
      end
  end
end
