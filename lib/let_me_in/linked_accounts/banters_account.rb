module LetMeIn
  module LinkedAccounts
    module BantersAccount
      extend ActiveSupport::Concern
      
      module InstanceMethods
        
        def link(auth_hash, user)
          update_attributes({
            :user_id => user.id,
            :token => auth_hash[:credentials][:token],
            :app_user_id => auth_hash[:uid],
            :app_username => auth_hash[:info][:nickname],
            :image_url => auth_hash[:info][:image]
          })
        end
        
      end
      
      
      module ClassMethods
        
        def link(auth_hash, user)
          account = find_or_create_by_user_id(:user_id => user.id)
          account.link(auth_hash, user)
        end
        
      end
      
    end
  end
end