require 'sinatra/sequel'
require 'sqlite3'

configure :development do
  set :database, 'sqlite://development.sqlite'
end
configure :test do
  set :database, 'sqlite3::memory:'
end

require 'config/migrations'

Dir["models/**/*.rb"].each{|model|
  require model
}
