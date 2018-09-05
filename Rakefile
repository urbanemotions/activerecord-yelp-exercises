require_relative './config/environment'
require 'sinatra/activerecord/rake'

namespace :db do

  desc "drop and recreate the db"
  task :reset => [:drop, :migrate]

  desc "drop the db"
  task :drop do
    connection_details = YAML::load(File.open('config/database.yml'))
    File.delete(connection_details.fetch('database')) if File.exist?(connection_details.fetch('database'))
  end
  
end

desc "start pry console"
task :console do
  Pry.start
end
