require 'rubygems'
require 'sinatra'
require 'config/init'


get '/' do
  @person = Person.rand
  erb :home
end

get '/people' do
  @people = Person.all
  erb :people_index
end

get '/people/new' do
  @person = Person.new
  erb :people_new
end

post '/people' do
  person = Person.new(params).save or halt 400
  redirect "/people/#{person.id}"
end

get '/people/:id' do
  @person = Person[params[:id]] or halt 404
  erb :people_show
end

get '/people/:id/edit' do
  @person = Person[params[:id]] or halt 404
  erb :people_edit
end

put '/people/:id' do
  @person = Person[params[:id]] or halt 404
  @person.update(params) or halt 400
  redirect "/people/#{@person.id}"
end

delete '/people/:id' do
  @person = Person[params[:id]] or halt 404
  @person.delete
  redirect '/people'
end
