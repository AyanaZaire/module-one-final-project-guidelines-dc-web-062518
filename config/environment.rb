require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
# ActiveRecord::Base.connection.clear_query_cache

require_all 'lib'


require_all 'app'
require_relative '../bin/run_commands.rb'
