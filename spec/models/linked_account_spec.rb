require 'spec_helper'
require 'ostruct'

describe User do
  
  before(:each) do
    user_attr = {
      :username => "tester",
      :email => "tester@example.com",
      :password => "testing", 
      :password_confirmation => "testing"
    }
    @user = User.create(user_attr)
    @attr = {
      :user_id => @user.id,
      :token => 'TOKEN',
      :secret => 'SECRET',
      :refresh_token => 'REFRESH',
      :app_username => 'TESTER',
      :app_user_id => '123',
      :url => 'http://example.com/tester',
      :image_url => 'http://example.com/tester.png'
    }
    @linked_account = LinkedAccount.create!(@attr)
  end
  
  specify { @linked_account.user.should_not be_nil }
  specify { @linked_account.token.should == "TOKEN" }
  specify { @linked_account.secret.should == "SECRET" }
  specify { @linked_account.refresh_token.should == "REFRESH" }
  specify { @linked_account.app_username.should == "TESTER" }
  specify { @linked_account.app_user_id.should == "123" }
  specify { @linked_account.url.should == 'http://example.com/tester' }
  specify { @linked_account.image_url.should == 'http://example.com/tester.png' }
  
  describe "unlink" do
    it "should destroy the account" do
      @linked_account.unlink
      @user.linked_accounts.length.should == 0
    end
  end

  describe "invalidate_tokens" do
    before do
      @linked_account.invalidate_tokens
    end
    
    specify { @linked_account.token.should be_nil }
    specify { @linked_account.secret.should be_nil }
  end

  describe "serializable hash" do
    let(:hash) { @linked_account.serializable_hash }
    specify { hash[:token].should be_nil }
    specify { hash[:secret].should be_nil }
    specify { hash[:refresh_token].should be_nil }
    specify { hash[:connected].should be_true }
  end
  
  describe "Banters" do
    before do
      @auth_hash = {
        :credentials => {:token => "BANTERS_TOKEN"},
        :uid => '1234',
        :info => {:nickname => 'banters-tester', :image => 'http://example.com/banters.png'}
      }
    end
    
    describe "link" do
      before do
        @acct = Banters.link(@auth_hash, @user)
      end

      specify { @acct.user_id.should eq(@user.id) }
      specify { @acct.token.should == "BANTERS_TOKEN" }
      specify { @acct.refresh_token.should be_nil }
      specify { @acct.app_username.should == "banters-tester" }
      specify { @acct.app_user_id.should == "1234" }
      specify { @acct.url.should be_nil }
      specify { @acct.image_url.should == 'http://example.com/banters.png' }
    end
  end
  
  describe "Instagram" do
    before do
      @auth_hash = {
        :credentials => {:token => "INSTAGRAM_TOKEN", :secret => "INSTAGRAM_SECRET"},
        :uid => '1234',
        :info => {:nickname => 'instagram-tester', :image => 'http://example.com/instagram.png'}
      }
    end
    
    describe "link" do
      before do
        @acct = Instagram.link(@auth_hash, @user)
      end

      specify { @acct.user_id.should eq(@user.id) }
      specify { @acct.token.should == "INSTAGRAM_TOKEN" }
      specify { @acct.secret.should == "INSTAGRAM_SECRET" }
      specify { @acct.refresh_token.should be_nil }
      specify { @acct.app_username.should == "instagram-tester" }
      specify { @acct.app_user_id.should == "1234" }
      specify { @acct.url.should be_nil }
      specify { @acct.image_url.should == 'http://example.com/instagram.png' }
    end
  end

  describe "Twitter" do
    before do
      @auth_hash = {
        :credentials => {:token => "TWITTER_TOKEN", :secret => "TWITTER_SECRET"},
        :uid => '1234',
        :info => {:nickname => 'twitter-tester', 
                  :image => 'http://example.com/twitter.png',
                  :urls => {'Twitter' => 'http://twitter.com/twitter-tester'}}
      }
    end

    describe "link" do
      before do
        @acct = Twitter.link(@auth_hash, @user)
      end

      specify { @acct.user_id.should eq(@user.id) }
      specify { @acct.token.should == "TWITTER_TOKEN" }
      specify { @acct.secret.should == "TWITTER_SECRET" }
      specify { @acct.refresh_token.should be_nil }
      specify { @acct.app_username.should == "twitter-tester" }
      specify { @acct.app_user_id.should == "1234" }
      specify { @acct.url.should == 'http://twitter.com/twitter-tester' }
      specify { @acct.image_url.should == 'http://example.com/twitter.png' }
    end
  end
  
end