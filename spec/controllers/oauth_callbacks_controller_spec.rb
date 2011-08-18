require 'spec_helper'

describe OauthCallbacksController do

  describe 'GET #google with request env' do
    before do
      request.env['omniauth.auth'] = {'provider' => 'google', 'uid' => 'someone@gmail.com'}
    end

    it 'should redirect and have auth success notice' do
      get 'google'
      response.should be_redirect
      flash[:notice].should match(I18n.translate(:auth_success, :scope => [:flash]))
    end
  end

  describe 'GET #google without request env' do
    it 'should redirect and have no auth data error' do
      get 'google'
      response.should be_redirect
      flash[:error].should match(I18n.translate(:no_auth_data, :scope => [:flash]))
    end
  end

  describe 'GET #google with bad request env' do
    before do
      request.env['omniauth.auth'] = {'provider' => 'google'}
    end

    it 'should redirect and have create user error' do
      get 'google'
      response.should be_redirect
      flash[:error].should match(I18n.translate(:create_user_error, :scope => [:flash]))
    end
  end
  
  describe 'GET #facebook with request env' do
    before do
      request.env['omniauth.auth'] = {'provider' => 'facebook', 'uid' => '111111111'}
    end

    it 'should redirect and have auth success notice' do
      get 'facebook'
      response.should be_redirect
      flash[:notice].should match(I18n.translate(:auth_success, :scope => [:flash]))
    end
  end

  describe 'GET #facebook without request env' do
    it 'should redirect and have no auth data error' do
      get 'facebook'
      response.should be_redirect
      flash[:error].should match(I18n.translate(:no_auth_data, :scope => [:flash]))
    end
  end

  describe 'GET #facebook with bad request env' do
    before do
      request.env['omniauth.auth'] = {'provider' => 'facebook'}
    end

    it 'should redirect and have create user error' do
      get 'facebook'
      response.should be_redirect
      flash[:error].should match(I18n.translate(:create_user_error, :scope => [:flash]))
    end
  end
  
  describe 'GET #twitter with request env' do
    before do
      request.env['omniauth.auth'] = {'provider' => 'twitter', 'uid' => '11111111'}
    end

    it 'should redirect and have auth success notice' do
      get 'twitter'
      response.should be_redirect
      flash[:notice].should match(I18n.translate(:auth_success, :scope => [:flash]))
    end
  end

  describe 'GET #twitter without request env' do
    it 'should redirect and have no auth data error' do
      get 'twitter'
      response.should be_redirect
      flash[:error].should match(I18n.translate(:no_auth_data, :scope => [:flash]))
    end
  end

  describe 'GET #twitter with bad request env' do
    before do
      request.env['omniauth.auth'] = {'provider' => 'twitter'}
    end

    it 'should redirect and have create user error' do
      get 'twitter'
      response.should be_redirect
      flash[:error].should match(I18n.translate(:create_user_error, :scope => [:flash]))
    end
  end
  
  describe 'GET #tumblr with request env' do
    before do
      request.env['omniauth.auth'] = {'provider' => 'tumblr', 'uid' => 'zquestz'}
    end

    it 'should redirect and have auth success notice' do
      get 'tumblr'
      response.should be_redirect
      flash[:notice].should match(I18n.translate(:auth_success, :scope => [:flash]))
    end
  end

  describe 'GET #tumblr without request env' do
    it 'should redirect and have no auth data error' do
      get 'tumblr'
      response.should be_redirect
      flash[:error].should match(I18n.translate(:no_auth_data, :scope => [:flash]))
    end
  end

  describe 'GET #tumblr with bad request env' do
    before do
      request.env['omniauth.auth'] = {'provider' => 'tumblr'}
    end

    it 'should redirect and have create user error' do
      get 'tumblr'
      response.should be_redirect
      flash[:error].should match(I18n.translate(:create_user_error, :scope => [:flash]))
    end
  end
  
  describe 'GET #failure' do
    it 'should redirect and have auth failed error' do
      get 'failure'
      response.should be_redirect
      flash[:error].should match(I18n.translate(:auth_failed, :scope => [:flash]))
    end
  end

  describe 'GET #logout' do
    it 'should redirect and have logged out notice' do
      get 'logout'
      flash[:notice].should match(I18n.translate(:logged_out, :scope => [:flash]))
      session[:user_id].should be_blank
    end
  end

end
