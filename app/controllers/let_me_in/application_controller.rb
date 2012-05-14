module LetMeIn
  class ApplicationController < ActionController::Base
    include SessionsHelper
    before_filter :load_hbs_helpers
    respond_to :html, :json

    def load_hbs_helpers
      LetMeIn::HandlebarsConfig.register_partials
    end
  end
end
