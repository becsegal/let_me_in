module LetMeIn
  class LinkedAccountsController < ApplicationController
    before_filter :authenticate
  
    def index
      render_or_redirect current_user.linked_accounts
    end
  end
end