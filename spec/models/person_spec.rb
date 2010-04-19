require File.dirname(__FILE__) + '/../spec_helper'

describe Person do
  describe "validations" do
   it "should require a name" do
    Person.new().should_not be_valid
    Person.new(:name => '').should_not be_valid
    Person.new(:name => "Maggie").should be_valid
   end
  end
end