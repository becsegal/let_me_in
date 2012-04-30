class User < OmniAuth::Identity::Models::ActiveRecord
  include LetMeIn::LinkedAccounts::Identity
  
  has_linked_accounts
end