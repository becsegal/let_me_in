module LetMeIn
  class LinkedAccount < ActiveRecord::Base
    set_table_name "linked_accounts"
    
    belongs_to :user

    attr_accessible :type, :user_id, :token, :secret, :app_username, :app_user_id, :url, :image_url
    cattr_accessor :account_types
    
    
    def serializable_hash options={}
      options ||= {}
      options[:except] = (options[:except] || []) | [:token, :secret]
      hash = super options
      hash.merge!(:connected => connected?, :type => type.split('::').last)
      hash
    end
    
    def self.link(auth_hash, user)
      nil
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
    
    def self.short_name
      name.split('::')
    end

    def self.available_types
      @@account_types ||= Dir["app/models/let_me_in/linked_account/*.rb"].map{|f| File.basename(f, '.*').camelize }.sort
    end

    def self.key
      nil
    end

    def self.secret
      nil
    end

    def self.available?
      key && secret
    end

    def self.invalidate_tokens
      false
    end

    def self.key
      ENV["#{short_name.last.upcase}_KEY"]
    end

    def self.secret
      ENV["#{short_name.last.upcase}_SECRET"]
    end

  end
end
