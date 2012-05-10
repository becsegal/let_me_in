begin
  if user = User.first
    user.linked_accounts.find_or_create_by_type(:type => 'Banters')
    user.linked_accounts.find_or_create_by_type(:type => 'Instagram')
    user.linked_accounts.find_or_create_by_type(:type => 'Twitter')
  end  
rescue
  Rails.logger.warn "[WARN] failed to initialize linked accounts #{$!}"
end