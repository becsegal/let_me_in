module LetMeIn
  class SessionsController < ApplicationController
    before_filter :already_signed_in, :only => :new
    
    def new
      save_return_path
    end
  
    def destroy
      sign_out
      reset_session
      redirect_to signin_path
    end
    
    private
      def already_signed_in
        if signed_in?
          redirect_to main_app.post_login_path
        end
      end
  end
end
