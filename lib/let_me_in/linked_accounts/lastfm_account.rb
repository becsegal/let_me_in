module LetMeIn
  module LinkedAccounts
    module LastfmAccount
      extend ActiveSupport::Concern

      
      module InstanceMethods
      
        def link(auth_hash, user)
          update_attributes({
            :user_id => user.id,
            :token => auth_hash[:credentials][:token],
            :secret => nil, #auth_hash[:credentials][:secret],
            :app_user_id => auth_hash[:uid],
            :app_username => auth_hash[:info][:name],
            :url => "http://www.last.fm/user/#{auth_hash[:uid]}",
            :image_url => nil #auth_hash[:info][:image]
          })
          self
        end
        
      end

      module ClassMethods
        
        def link(auth_hash, user)
          account = self.find_or_create_by_user_id(:user_id => user.id)
          account.link(auth_hash, user)
        end
        
      end
    
    
    end
  end
end
