class User < ActiveRecord::Base

  #:belongs to :book
  has_many :user_book_choices
  has_many :books, through: :user_book_choices

  def add_to_book_choices(book_id)
    self.books << Book.find(book_id)
    UserBookChoice.create(book_id: book_id, user_id: self.id)
  end

  def see_book_choices
    # returns all items in user choice database
    self.books.each do |book|
      puts "Book Id: #{book.id} — #{book.title} by #{book.author}"
    end
  end

  # def update_book_choices
  #   # get response of book_id from user
  #   UserBookChoice.update(book_id: )
  # end

  def delete_book_choice(book_id)
    #destroy book object based on book_id given from user
    self.books.destroy(book_id)
    # UserBookChoice.where(book_id: book_id, user_id: self.id).destroy_all
  end

end
