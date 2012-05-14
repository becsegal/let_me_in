class LinkedAccount < ActiveRecord::Base
  include LetMeIn::LinkedAccounts::Account
  is_a_linked_account
end