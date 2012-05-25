module LetMeIn
  class ApplicationController < ActionController::Base
    include SessionsHelper
    respond_to :html, :json
  end
end
