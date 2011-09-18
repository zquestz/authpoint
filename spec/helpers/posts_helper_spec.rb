require 'spec_helper'

describe PostsHelper do
  before do
    @post = Factory(:post)
  end
  
  context '#linked_tag_list' do
    it 'should output nothing if there is no tags' do
      linked_tag_list(@post).should be_blank
    end
    
    it 'should output a list of linked tags' do
      @post.tag_list = 'tag1, tag2, tag3, tag4'
      @post.save
      linked_tag_list(@post).should match(/.*tag=tag1.*>tag1<\/a>,.*tag=tag2.*>tag2<\/a>,.*tag=tag3.*>tag3<\/a>,.*tag=tag4.*>tag4<\/a>/)
    end
  end
end
