require 'spec_helper'
require 'ostruct'

describe User do
  
  before(:each) do
    @attr = {
      :username => "tester",
      :email => "tester@example.com",
      :password => "testing", 
      :password_confirmation => "testing"
    }
  end
  
  describe "validations" do
    specify { User.new(@attr).should be_valid }

    it "should require a username" do
      User.new(@attr.delete('username')).should_not be_valid 
    end

    it "should not allow a username with an @ symbol" do
      User.new(@attr.merge(:username => '@username')).should_not be_valid 
    end
  
    it "should require an email address" do
      User.new(@attr.delete('email')).should_not be_valid
    end
  
    it "should require a valid email address format" do
      User.new(@attr.merge(:email => 'bad_email')).should_not be_valid
    end
  
    it "should require a password" do
      User.new(@attr.delete('password')).should_not be_valid
    end

    it "should require a password confirmation" do
      User.new(@attr.delete('password_confirmation')).should_not be_valid
    end
    
    it "should require a matching password and confirmation" do
      User.new(@attr.merge(:password_confirmation => 'fail')).should_not be_valid
    end
  end
  
  describe "authentication" do
    let(:user) { User.create!(@attr) }
    
    context "with username and password" do
      specify { User.authenticate(user.username, @attr[:password]).should eq user }
      specify { User.authenticate('wrong-username', @attr[:password]).should be_false }
      specify { User.authenticate(user.username, 'wrong-password').should be_false }
    end

    context "with email and password" do
      specify { User.authenticate(user.email, @attr[:password]).should eq user }
      specify { User.authenticate('wrong@email.com', @attr[:password]).should be_false }
      specify { User.authenticate(user.email, 'wrong-password').should be_false }
    end

    context "with token" do
      specify { User.authenticate_with_token(user.id, user.auth_token).should eq user }
      specify { User.authenticate(user.id + 1, user.auth_token).should be_false }
      specify { User.authenticate(user.id, 'wrong-token').should be_false }
    end
  end
  
  describe "find_or_create_with_auth_hash" do
    let(:user) { User.create!(@attr) }

    context "with identity" do
      specify { 
        hash = OpenStruct.new('provider' => 'identity', 'uid' => user.id)
        User.find_or_create_by_auth_hash(hash).should eq user 
      }
      specify { 
        hash = OpenStruct.new('provider' => 'identity', 'uid' => user.id + 1)
        User.find_or_create_by_auth_hash(hash).should be_nil 
      }
    end
  end
  
  describe "serializable_hash" do
    let(:user) { User.create!(@attr) }
    specify { user.serializable_hash[:password_digest].should be_nil }
    specify { user.serializable_hash[:auth_token].should be_nil }
  end
  
end