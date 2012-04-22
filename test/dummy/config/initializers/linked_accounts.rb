
LetMeIn::Engine.config.linked_account_classes << Instagram
LetMeIn::Engine.config.linked_account_classes << Twitter
LetMeIn::Engine.config.linked_account_classes << Banters

if user = LetMeIn::User.first
  user.linked_accounts.find_or_create_by_type(:type => 'Banters')
  user.linked_accounts.find_or_create_by_type(:type => 'Instagram')
  user.linked_accounts.find_or_create_by_type(:type => 'Twitter')
end  