Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.sequence :username do |n|
  "user#{n}"
end

Factory.define :user do |user|
  user.password                   "password"
  user.password_confirmation      "password"
  user.after_build do |u|
    u.email ||= Factory.next(:email)
    u.username ||= Factory.next(:username)    
  end
end

Factory.define :linked_account do |linked_account|
  linked_account.token        "token"
  linked_account.secret       "secret"
  linked_account.after_build do |la|
    la.user_id ||= Factory(:user).id
    la.type ||= "Banters"
  end
end