require 'pry'
def welcome_user(user)
  puts "Welcome, #{user.name}!"
end

def get_command
  puts "What would you like to do now? (Please, type in your command below)"
  command = gets.chomp
  puts "================"
  command
end

def help_method
  puts "Here are some commands you can type into our app:"
  puts "'my list' - to see you your reading list."
  puts "'all books' - to see all the books in our database."
  puts "'search google' - to find books via google search."
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
    if user.books == []
      puts "You don't have any books in your list!"
    else
      user.see_book_choices
    end
    execute_command(get_command, user)
  elsif command == "all books"
    Book.see_all_books
    execute_command(get_command, user)
  elsif command == "remove from list"
    remove_from_list(user)
  elsif command == "search google"
    puts "Please type your search term:"
    search_term = gets.chomp
    find_book_by_search_term(search_term, user)
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
  puts "================"
  if input == "all books"
    # we wanted to allow the user to see all books before making their choice.
    Book.see_all_books
    puts "Now that you've seen all the books..."
    add_to_list_command(user)
  elsif Book.exists?(input) == false
    # this checks to see if the book exists in the database.
    # The "input" is always a string, so we converted it to an integer and checked to see if it's an integer
    puts "We're sorry, we couldn't find a book with that ID."
    execute_command("add to list", user)
  elsif Book.exists?(input) == true
    # this executes only if the book exists in the database.
    book = Book.find(input)
    if user.books.include?(book)
      #this checks if the book already exists in that user's list
      puts "This book is already in your list!"
    else
      user.add_to_book_choices(input)
      #if the book isn't already in their list, this adds the book to their list
      puts "Great! #{book.title} by #{book.author} has been added to your list."
      show_list(user)
    end
    execute_command(get_command, user)
  else
    invalid_command(user)
  end
end

def show_list(user)
  puts "Here is your new list:"
  user.see_book_choices
end

def remove_from_list(user)
  puts "Which book would you like to remove?"
  puts "Please type in the book ID."
  puts "(If you'd like to see your book list, type 'my list'. If you don't want to remove a book from your list, type 'go home')"
  input = gets.chomp
  puts "================"
  if input == "my list" #this is the case where they want to see their list first
    user.see_book_choices
    puts "Now that you've seen your list, input the book ID of the book you'd like to remove."
    id = gets.chomp
    user.delete_book_choice(id)
    show_list(user)
    execute_command(get_command, user)
  elsif input == "go home"
    # this is if the user decides they don't want to remove a book after all
    execute_command(get_command, user)
  elsif Book.exists?(input) && user.books.include?(Book.find(input)) == false
    # this is the case where the book doesn't exist in their list
    puts "Sorry, your list doesn't have a book with that ID number."
    execute_command("remove from list", user)
  elsif Book.exists?(input) && user.books.include?(Book.find(input))
    # this is the case where they put in a bookid and it exists in their list
    user.delete_book_choice(input)
    show_list(user)
    execute_command(get_command, user)
  elsif Book.exists?(input) == false
    # this is if the input is either not an integer or there is not a book with that ID.
    puts "Sorry, our database doesn't have a book with that ID."
    execute_command("remove from list", user)
  else
    # unknown command
    invalid_command(user)
  end
end

def find_book_by_search_term(search_term, user)
  a = search_term.split(" ")
  a = a.join("%20")
  all_books = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{a}")
  book_array = JSON.parse(all_books)["items"].first(10).to_a
  book_array.each_with_index do |book_hash, index|
    puts "Index #{index + 1}: #{book_hash["volumeInfo"]["title"]} by #{book_hash["volumeInfo"]["authors"][0]}"
  end
  puts "-----------------"
  puts "To add one of these books to your list, please type the index number below. Otherwise, type 'go home'."
  input = gets.chomp
  if input == "go home"
    execute_command(get_command, user)
  else
    index = input.to_i - 1
    title = book_array[index]["volumeInfo"]["title"]
    author = book_array[index]["volumeInfo"]["authors"][0]
    book = Book.find_or_create_by(title: title, author: author)
    UserBookChoice.create(user_id: user.id, book_id: book.id)
    user.reload
    show_list(user)
    execute_command(get_command, user)
  end
end
