require_relative '../config/environment'
require_relative 'run_commands.rb'

puts "Welcome to Philo! To get started, please enter your name here:"
name = gets.chomp
puts "================"
user = User.find_or_create_by(name: name)

welcome_user(user)
execute_command(help_method, user)



Pry.start
