module LetMeIn
  class User < OmniAuth::Identity::Models::ActiveRecord
    set_table_name "users"
  
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

    validates :password,
              :presence => true,
              :confirmation => true,
              :length => { :minimum => 6 }

    before_create :generate_auth_token


    def self.find_or_create_by_auth_hash(auth_hash)
      Rails.logger.debug "auth_hash: #{auth_hash.inspect}"
      if auth_hash.provider == "identity"
        # Only find with identity provider, create is handled by the omniauth gem
        # Don't need to validate password. omniauth gem does that too
        user = find_by_id(auth_hash.uid)
      end
      user
    end

    def self.authenticate(username_or_email, password)
      where(["email=:username_or_email or username=:username_or_email", :username_or_email => username_or_email])
        .first.try(:authenticate, password)
    end

    def self.authenticate_with_token id, token
      user = find_by_id(id)
      (user && user.auth_token == token) ? user : nil
    end

    private

      def generate_auth_token
        self.auth_token = SecureRandom.urlsafe_base64
      end
  end
end