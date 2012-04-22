module LetMeIn
  
  class Twitter < LinkedAccount

    DEV_URL = "https://dev.twitter.com/apps"

    def self.link(auth_hash, user)
      account = self.find_or_create_by_user_id(:user_id => user.id)
      account.link(auth_hash, user)
    end
    
    def link(auth_hash, user)
      update_attributes({
        :user_id => user.id,
        :token => auth_hash[:credentials][:token],
        :secret => auth_hash[:credentials][:secret],
        :app_user_id => auth_hash[:uid],
        :app_username => auth_hash[:info][:nickname],
        :url => auth_hash[:info][:urls]['Twitter'],
        :image_url => auth_hash[:info][:image]
      })
    end
    
  end
  
end