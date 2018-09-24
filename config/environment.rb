ENV['RAILS_ENV'] ||= "development"

require "bundler/setup"
require "sinatra/activerecord"

Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['RAILS_ENV']}.sqlite"
)

require_all 'app'
