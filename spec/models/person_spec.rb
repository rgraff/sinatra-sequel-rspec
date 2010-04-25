require File.dirname(__FILE__) + '/../spec_helper'

describe Person do
  before :each do
    Person.delete
  end
  describe "#rand" do
    describe "with no records" do
      it "should return nil" do
        Person.rand.should be_nil
      end
    end
    describe "with one record" do
      before :each do
        @person = Person.new(:name => "Maggie").save
      end
      it "should return the one record" do
        Person.rand.should == @person
      end
    end
    describe "with two records" do
      before :each do
        @person = Person.new(:name => "Maggie").save
        @another = Person.new(:name => "Audrey").save
      end
      it "should return one or the other" do
        [@person, @another].should include(Person.rand)
      end
    end
  end
  
  describe "validations" do
   it "should require a name" do
    Person.new().should_not be_valid
    Person.new(:name => '').should_not be_valid
    Person.new(:name => "Maggie").should be_valid
   end
  end
end