require 'spec_helper'

describe Credential do
  describe 'basic creation' do
    it 'should not create an empty credential' do
      cred = Credential.new
      cred.should be_invalid
    end

    it 'should not save if there is no user' do
      cred = Credential.new(:provider => 'google', :uid => 'minimal@gmail.com')
      cred.should_not be_valid
      cred.save.should be_false
    end

    it 'should save if we pass a valid user, provider, and uid' do
      user = Factory(:user)
      cred = Credential.new(:user => user, :provider => 'google', :uid => 'minimal@gmail.com')
      cred.should be_valid
      cred.save.should be_true
    end
  end
  
  describe 'providers' do
    context 'google' do
      before do
        user = Factory(:user)
        @cred = Credential.new(:user => user, :provider => 'google', :uid => 'minimal@gmail.com')
      end
    
      it 'should be a google credential' do
        @cred.google?.should be_true
      end
    
      it 'should not be a facebook credential' do
        @cred.facebook?.should be_false
      end
    
      it 'should not be a twitter credential' do
        @cred.twitter?.should be_false
      end
      
      it 'should not be a tumblr credential' do
        @cred.tumblr?.should be_false
      end
    end
  
    context 'facebook' do
      before do
        user = Factory(:user)
        @cred = Credential.new(:user => user, :provider => 'facebook')
      end
    
      it 'should not be a google credential' do
        @cred.google?.should be_false
      end
    
      it 'should be a facebook credential' do
        @cred.facebook?.should be_true
      end
    
      it 'should not be a twitter credential' do
        @cred.twitter?.should be_false
      end
      
      it 'should not be a tumblr credential' do
        @cred.tumblr?.should be_false
      end
    end
  
    context 'twitter' do
      before do
        user = Factory(:user)
        @cred = Credential.new(:user => user, :provider => 'twitter')
      end
    
      it 'should not be a google credential' do
        @cred.google?.should be_false
      end
    
      it 'should not be a facebook credential' do
        @cred.facebook?.should be_false
      end
    
      it 'should be a twitter credential' do
        @cred.twitter?.should be_true
      end
      
      it 'should not be a tumblr credential' do
        @cred.tumblr?.should be_false
      end
    end
    
    context 'tumblr' do
      before do
        user = Factory(:user)
        @cred = Credential.new(:user => user, :provider => 'tumblr')
      end
    
      it 'should not be a google credential' do
        @cred.google?.should be_false
      end
    
      it 'should not be a facebook credential' do
        @cred.facebook?.should be_false
      end
    
      it 'should not be a twitter credential' do
        @cred.twitter?.should be_false
      end
            
      it 'should be a tumblr credential' do
        @cred.tumblr?.should be_true
      end
    end
  end

  describe 'url generation' do
    it 'should have nice param output' do
      cred = Factory(:credential)
      cred.to_param.should == "#{cred.id}-#{cred.uid.parameterize}"
    end
  end
end
