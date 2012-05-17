module LetMeIn
  module LinkedAccounts
    module Account
      extend ActiveSupport::Concern
      
      module InstanceMethods
        
        def serializable_hash options={}
          options ||= {}
          options[:except] = (options[:except] || []) | [:token, :secret, :refresh_token]
          hash = super options
          hash.merge!(:connected => connected?, :type => (type || '').split('::').last)
          hash
        end
        
        def link(auth_hash, user)
          nil
        end

        def unlink
          destroy
        end

        def connected?
          token?
        end
        
        def invalidate_tokens
          update_attributes(:token => nil, :secret => nil)
        end
        
      end
      
      
      module ClassMethods
        
        def is_a_linked_account
          belongs_to :user
          attr_accessible :type, :user_id, :token, :secret, :refresh_token, 
                          :app_username, :app_user_id, :url, :image_url
        end
        
        
        def link(auth_hash, user)
          nil
        end
        
        def short_name
          name.split('::').last
        end
        
        def available?
          key && secret
        end
        
        def key
          ENV["#{short_name.upcase}_KEY"]
        end
        
        def secret
          ENV["#{short_name.upcase}_SECRET"]
        end
        
        def as_json_with_short_name(options={})
          {:type => short_name}
        end
        alias_method :as_json, :as_json_with_short_name
      end
    end
  end
end