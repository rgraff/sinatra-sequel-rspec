require File.dirname(__FILE__) + '/spec_helper'

describe "App" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end
  
  describe "get /" do
    it "should say Hello World if there are no people" do
      Person.delete
      get '/'
      last_response.should be_ok
      last_response.body.should match /Hello World/
    end
    
    it "should say Hello to someone if there is a person" do
      Person.delete
      Person.new(:name => 'Maggie').save
      get '/'
      last_response.should be_ok
      last_response.body.should match /Hello Maggie/
    end
  end
  
  describe "get /people" do
    it "should show a list of people" do
      Person.delete
      Person.new(:name => 'Maggie').save
      Person.new(:name => 'Audrey').save
      get '/people'
      last_response.should be_ok
      last_response.body.should match /Maggie/
      last_response.body.should match /Audrey/
    end
  end
  
  describe "get /people/new" do
    it "should have a form" do
      get '/people/new'
      last_response.should be_ok
      last_response.should match /<form action="\/people" method="post">/
    end
  end
  
  describe "post /people" do
    it "should create a new person" do
      Person.delete
      post '/people', :name => 'Jane'
      
      person = Person.first
      person.should_not be_nil
      
      follow_redirect!

      last_request.url.should == "http://example.org/people/#{person.id}"
      last_response.should be_ok
    end
  end
  
  describe "get /people/:id" do
    it 'should show the person' do
      person = Person.new(:name => 'Maggie').save
      get "/people/#{person.id}"
      
      last_response.should be_ok
      last_response.should match /Maggie/
    end
  end
  
  describe "get /people/:id/edit" do
    before :each do
      @person = Person.new(:name => 'Maggie').save
      get "/people/#{@person.id}/edit"
    end

    it "should have a form" do
      last_response.should be_ok
      last_response.should match /<form action="\/people/#{@person.id}" method="post">/
    end
    
    it "should have the fields defaulted" do
      last_response.should be_ok
      last_response.should match /<input type="text" name="name" value="Maggie"\/>/
    end
  end
  
  describe "put /people/:id" do
    it "should update the record" do
      person = Person.new(:name => 'Maggie').save
      put "/people/#{person.id}", :name => 'Margaret'
      person.reload.name.should == 'Margaret'
      
      follow_redirect!

      last_request.url.should == "http://example.org/people/#{person.id}"
      last_response.should be_ok
    end
  end
  
  describe "delete /people/:id" do
    it "should delete the record" do
      person = Person.new(:name => 'Maggie').save
      delete "/people/#{person.id}"
      lambda{person.reload}.should raise_error
    
      follow_redirect!
    
      last_request.url.should == "http://example.org/people"
      last_response.should be_ok
    end
  end
end

