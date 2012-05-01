module LetMeIn
  module LinkedAccounts
    module Account
      extend ActiveSupport::Concern
      
      module InstanceMethods
        
        def serializable_hash options={}
          options ||= {}
          options[:except] = (options[:except] || []) | [:token, :secret, :refresh_token]
          hash = super options
          hash.merge!(:connected => connected?, :type => type.split('::').last)
          hash
        end
        
        def link(auth_hash, user)
          nil
        end

        def unlink
          update_attributes(:token => nil, :secret => nil, :app_user_id => nil, :app_username => nil,
                            :url => nil, :image_url => nil)
        end

        def connected?
          token?
        end
        
      end
      
      
      module ClassMethods
        
        def belongs_to_user
          belongs_to :user
          attr_accessible :type, :user_id, :token, :secret, :app_username, :app_user_id, :url, :image_url
          cattr_accessor :account_types
        end
        
        
        def link(auth_hash, user)
          nil
        end
        
        def short_name
          name.split('::').last
        end
        
        def key
          nil
        end
        
        def secret
          nil
        end
        
        def available?
          key && secret
        end
        
        def invalidate_tokens
          false
        end
        
        def key
          ENV["#{short_name.upcase}_KEY"]
        end
        
        def secret
          ENV["#{short_name.upcase}_SECRET"]
        end
      end
    end
  end
end