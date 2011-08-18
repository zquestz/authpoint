require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ApplicationHelper do

  describe 'link helpers' do
    it 'should provide a convenience method for displaying urls' do
      helper.display_website('http://google.com').should match('href="http://google.com"')
      helper.display_website('http://google.com').should match('>http://google.com<')
    end

    it 'should provide a convenience method for displaying emails' do
      helper.display_email('test@example.com').should match('mailto:test@example.com')
      helper.display_email('test@example.com').should match('>test@example.com<')
    end
  end

  describe 'flash messages' do
    it 'should render nothing if there is no flash messages' do
      helper.render_flash_messages.should be_blank
    end

    it 'should render notices if they are present' do
      flash[:notice] = 'A notice!'
      helper.render_flash_messages.should match('<div class="notice')
    end

    it 'should render errors if they are present' do
      flash[:error] = 'An error!'
      helper.render_flash_messages.should match('<div class="error')
    end

    it 'should render an error over a notice' do
      flash[:notice] = "You won't see me."
      flash[:error] = 'Wowza an error.'
      helper.render_flash_messages.should match('Wowza an error.')
    end
    
    it 'should have a rollup class for nice animations' do
      flash[:notice] = 'Another notice!'
      helper.render_flash_messages.should match(/class="\w* rollup"/)
    end
  end
  
  describe 'connected networks' do
    it 'should render an icon for a provider' do
      user = Factory(:user)
      credential = Factory(:credential, :user => user)
      subject.current_user = user
      helper.connected_networks.should match(/img.*#{credential.provider}/)
    end
  end
end
