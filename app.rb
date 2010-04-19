require 'rubygems'
require 'sinatra'
require 'config/init'

get '/hi' do
  "Hello World!"
end