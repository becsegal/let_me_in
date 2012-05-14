module LetMeIn
  module LinkedAccounts
    module Identity
      extend ActiveSupport::Concern
      
      module InstanceMethods
        
        def generate_auth_token
          self.auth_token = SecureRandom.urlsafe_base64
        end
        
        def serializable_hash options={}
          (options ||= {}).reverse_merge!({:exclude => []})
          options[:exclude] |= [:password_digest, :auth_token]
          super options
        end
        
      end
      
      
      module ClassMethods
        def has_identity
          
          has_secure_password
          has_many :linked_accounts
          
          attr_accessible :username, :email, :password, :password_confirmation
          
          validates :username, 
                    :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format => { :with => /\A[\w-]+\z/ },
                    :length => { :minimum => 3 }
                    
          validates :email,
                    :presence => true,
                    :format => { :with => /\A^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$\z/i },
                    :uniqueness => { :case_sensitive => false }
                    
          before_create :generate_auth_token
        end
        
        def find_or_create_by_auth_hash(auth_hash)
          if auth_hash.provider == "identity"
            # Only find with identity provider, create is handled by the omniauth gem
            # Don't need to validate password. omniauth gem does that too
            user = find_by_id(auth_hash.uid)
          end
          # TODO: implement create with 
          user
        end
        
        def authenticate(username_or_email, password)
          user = where(["email=:username_or_email or username=:username_or_email", 
                  :username_or_email => username_or_email]).first
          user.try(:authenticate, password)
        end
        
        def authenticate_with_token id, token
          user = find_by_id(id)
          (user && user.auth_token == token) ? user : nil
        end
      end
    end
  end
end