require 'spec_helper'

describe MainController do
  render_views
  
  describe 'GET #privacy' do
    it 'should be successful' do
      get 'privacy'
      response.should be_success
    end
  end

end
