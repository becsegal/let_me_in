require "let_me_in/engine"


# TODO: why do I need these here if they're in the gemspec/gemfile?
require "omniauth"
require "omniauth-identity"

require "let_me_in/linked_accounts/banters"
require "let_me_in/linked_accounts/instagram"
require "let_me_in/linked_accounts/twitter"

module LetMeIn
end
