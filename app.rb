require 'rubygems'
require 'sinatra'
require 'config/init'

get '/' do
  erb :home
end
