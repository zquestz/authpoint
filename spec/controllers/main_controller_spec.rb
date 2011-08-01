require 'spec_helper'

describe MainController do
  render_views

  describe 'GET #index' do
    context 'logged in' do
      it 'should be successful' do
        get 'index'
        response.should be_success
      end
    end
    
    context 'logged out' do
      it 'should be successful' do
        get 'index'
        response.should be_success
      end
    end
  end
  
  describe 'GET #privacy' do
    it 'should be successful' do
      get 'privacy'
      response.should be_success
    end
  end

end
