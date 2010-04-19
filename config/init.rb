require 'sinatra/sequel'
require 'sqlite3'

configure :development do
  set :database, 'sqlite://tmp/development.sqlite'
end
configure :test do
  set :database, 'sqlite3::memory:'
end

require 'config/migrations'