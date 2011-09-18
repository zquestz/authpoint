require 'spec_helper'

describe Post do
  describe 'basic creation' do
    before do
      @user = Factory(:user)
    end
    
    context 'without a user' do
      it 'should not create an empty post' do
        post = Post.new
        post.should be_invalid
      end
      
      it 'should not create with a message' do
        post = Post.new(:message => 'hi')
        post.should be_invalid
      end
    end
    
    context 'with a user' do
      it 'should not create an empty post' do
        post = Post.new(:user => @user)
        post.should be_invalid
      end
      
      it 'should save with user and message' do
        post = Post.new(:user => @user, :message => 'hi')
        post.should be_valid
        post.save.should be_true
      end
    end
  end
end