require 'spec_helper'

describe LetMeIn::AuthController, :type => :controller do

  describe "connect" do
    context "when not signed in" do
      it "should redirect to signin path" do
        get :connect, :provider => "whatever"
        response.should redirect_to signin_path
      end
    end
  
    context "when signed in" do
      before do
        @user = test_sign_in(Factory(:user))
      end
      
      it "should redirect to omniauth path" do
        get :connect, :provider => "whatever"
        response.should redirect_to "/auth/whatever"
      end
    end
  end

  describe "disconnect" do

    context "when not signed in" do
      it "should redirect to signin path" do
        get :disconnect, :provider => "whatever"
        response.should redirect_to signin_path
      end
    end
  
    context "when signed in" do
      before do
        @user = test_sign_in(Factory(:user))
        @linked_account = Factory(:linked_account, :user_id => @user.id, :type => "Banters")
        @params = {:provider => "banters", :id => @linked_account.id}
      end
      
      it "should destroy the account" do
        delete :disconnect, @params
        @user.linked_accounts.length.should == 0
      end  

      it "should be ok" do
        delete :disconnect, @params
        response.should redirect_to accounts_path
      end
      
      context "with json format" do
        before do
          @params.merge!(:format => :json)
        end
        
        it "should be ok" do
          delete :disconnect, @params
          response.should be_ok
        end
        
        it "should return empty data" do
          delete :disconnect, @params
          json = JSON.parse(response.body)
          json[:data].should be_nil
        end
      end
    end
  end
  
  describe "failure" do
    context "with identity" do
      before do
        request.env["omniauth.identity"] = Factory(:user)
      end  

      it "should redirect to accounts" do
        get :failure, @params
        response.code.should eq("400")
      end
      
      context "with json" do
        before do
          @params = {:format => :json}
        end
        
        it "should be a bad request" do
          get :failure, @params
          response.code.should eq("400")
        end
      end
    end
    
    context "with oauth"
  end
  
  describe "callback" do
  end
end

