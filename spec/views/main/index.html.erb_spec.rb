require 'spec_helper'

describe "main/index.html.erb" do
  before do 
    render
  end
  
  it 'should contain the text GooglePoint' do
    rendered.should include('GooglePoint')
  end
end
