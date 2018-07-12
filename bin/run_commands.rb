require 'pry'
def welcome_user(user)
  puts "Welcome, #{user.name}!"
end

def get_command
  puts "What would you like to do now? (Please, type in your command below)"
  command = gets.chomp
end

def help_method
  puts "Here are some commands you can type into our app:"
  puts "'my list' - to see you your reading list."
  puts "'all books' - to see all the books in our database."
  puts "'add to list' - to add a book to your reading list."
  puts "'remove from list' - to remove a book from your list."
  puts "'logout' - to log out of the app."
  puts "'help' - to see the list of commands again."
  get_command
end

def invalid_command(user)
  puts "Sorry, I don't recognize that command."
  execute_command(help_method, user)
end

def execute_command(command, user)
  if command == "add to list"
    add_to_list_command(user)
  elsif command == "logout"
    puts "Thanks for visiting Philo. Happy reading!"
  elsif command == "help"
    execute_command(help_method, user)
  elsif command == "my list"
    user.see_book_choices
    execute_command(get_command, user)
  elsif command == "all books"
    Book.see_all_books
    execute_command(get_command, user)
  elsif command == "remove from list"
    remove_from_list(user)
  else
    invalid_command(user)
  end
end

# def book_found?(id)
#   Book.all.each do |book|
#     if book.id.to_s == id
#       return true
#     end
#   end
#   false
# end


def add_to_list_command(user)
  # this method prompts the user to put in the book id of the book they want to add.
  puts "Which book would you like to add?"
  puts "(Please type in the book ID. If you'd like to see the book database, type 'all books')"
  input = gets.chomp
  # we wanted to allow the user to see all books before making their choice.
  if input == "all books"
    execute_command("all books", user)
  elsif Book.exists?(input) == false
    puts "We're sorry, we couldn't find a book with that number."
    execute_command("add to list", user)
  elsif Book.exists?(input) == true
    book = Book.find(input)
    if user.books.include?(book)
      puts "This book is already in your list!"
    else
      user.add_to_book_choices(input)
      puts "Great! #{book.title} by #{book.author} has been added to your list."
      puts "Here is your new list:"
      user.see_book_choices
    end
    execute_command(get_command, user)
  else
    invalid_command(user)
  end
end

def remove_from_list(user)
  puts "Which book would you like to remove?"
  puts "(Please type in the book ID. If you'd like to see your book list, type 'my list')"
  input = gets.chomp
  if input == "my list" #this is the case where they want to see their list first
    user.see_book_choices
    puts "Now that you've seen your list, input the book ID of the book you'd like to remove."
    id = gets.chomp
    user.delete_book_choice(id)
    puts "Here is your new list:"
    binding.pry
    user.see_book_choices
    execute_command(get_command, user)
  else # this is the case where they put in a bookid and it exists in their list
    user.delete_book_choice(input)
    puts "Here is your new list:"
    user.see_book_choices
    execute_command(get_command, user)
  #elsif # this is the case where the book doesn't exist in their list

  #elsif # unknown command
 end
end
