module LetMeIn
  class SessionsController < ApplicationController
    def new
    end
  
    def destroy
      sign_out
      reset_session
      redirect_to signin_path
    end
  
  end
end
