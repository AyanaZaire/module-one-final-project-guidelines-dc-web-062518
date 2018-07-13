require 'rest-client'
require 'json'
require 'pry'

class Book < ActiveRecord::Base

has_many :user_book_choices
has_many :users, through: :user_book_choices

  def self.see_all_books
    Book.all.each do |book|
      puts "Book Id: #{book.id} — #{book.title} by #{book.author}"
    end
  end

  

end

# hillary = User.create(name: "Hillary")
# UserCollection.create(book_id: 4, user_id: 9)
