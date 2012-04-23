module LetMeIn
  class ApplicationController < ActionController::Base
    include SessionsHelper
    before_filter :load_hbs_helpers

    def load_hbs_helpers
      logger.debug "LetMeIn::ApplicationController.load_hbs_helpers"
      LetMeIn::HandlebarsConfig.register_partials
    end
  end
end
