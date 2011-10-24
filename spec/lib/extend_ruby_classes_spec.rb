require 'spec_helper'

describe Hash do
  it 'should have recursive merge' do
    {
      :val => {
        :first => 1,
        :second => 2
      },
      :only_on_a => {
        :first => 1
      }
    }.recursive_merge({
      :val => {
        :first => 2,
        :third => 3
      },
      :only_on_b => {
        :first => 1
      }
    }).should == {
      :val => {
        :first => 2, 
        :second => 2, 
        :third => 3
      }, 
      :only_on_a => {
        :first => 1
      }, 
      :only_on_b => {
        :first => 1
      }
    }
  end
end