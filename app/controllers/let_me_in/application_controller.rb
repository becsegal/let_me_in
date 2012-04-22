module LetMeIn
  class ApplicationController < ActionController::Base
    include SessionsHelper
    before_filter :load_hbs_helpers

    def load_hbs_helpers
      return if !Rails.env.development?
      HandlebarsConfig.register_partials
    end
  end
end
