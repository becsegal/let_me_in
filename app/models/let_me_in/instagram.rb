module LetMeIn
  
  class Instagram < LinkedAccount

    DEV_URL = "http://instagr.am/developer/"
    API_URL = "https://api.instagram.com"

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
        :image_url => auth_hash[:info][:image]
      })
    end

  end
  
end