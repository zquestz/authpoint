require 'spec_helper'

describe Hash do
  it "should have recursive merge" do
    {
      :val => {
        :first => 1,
        :second => 2
      }
    }.recursive_merge({
      :val => {
        :first => 2,
        :third => 3
      }
    }).should == {:val => {:first => 2, :second => 2, :third => 3}}
  end
end