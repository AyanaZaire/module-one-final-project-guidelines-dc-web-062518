require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'


require_all 'app'
require_relative '../bin/run_commands.rb'
# require_relative "../app/models/book.rb"
# require_relative "../app/models/user.rb"
# require_relative "../app/models/usercollection.rb"
