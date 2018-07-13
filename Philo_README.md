# Philo App

## Introduction

Welcome!

We're glad you found Philo, a reading list app for philosophy book lovers.  The app is even better for those curious about philosophy and want to keep track of some popular books and authors to check out.

Philo is a Command Line CRUD App that accesses a Sqlite3 Database using ActiveRecord. Our three models are "User", "Book", and "User Book Choices" and their relationships are as follows:

1. "Book" has many "User Book Choices" AND has many "User" through "User Book Choices".
2. "User" has many "User Book Choices" AND has many "Book" through "User Book Choices".
3. "User Book Choices" belongs to "User" AND "Book"

"Book" and "User" are considered the parents because they are the models that "has many", while "User Book Choices" is considered the child because it is the model that "belongs to".  Through these relationships we have built out a CLI to give our user full CRUD ability. Some features a user can enjoy are creating a book list, reading their book choices, updating their book choices, deleting a book choice, and searching google for a book choice to add to their list. This 'search google' functionality allows the user to add books to their list that aren't already in the database. Under the hood, all of our commands are executed in our run.rb and run_commands.rb files.

## User Stories

Here is what you can do with Philo:

1. User can create a book list by adding a book choice.
2. User can see book choices.
3. User can update book choices
4. User can delete book choice.


## Instructions

1. Run Philo in your terminal with the following command: ruby bin/run.rb
2. You will be welcomed with a prompt, here is where you enter your name.
3. After entering your name, you will see a list of commands you can type into the app.  Type in 'all books' to view all the books in our database.
4. After looking over the list, feel free to input 'add to list' add one of the books to your list using its book ID.
5. After adding a book to your list, Philo will return your updated list.
6. If you don't see a book of interest in the database, you may input 'search google' and enter a topic you're curious about. After entering your search term Philo will return the top 10 book results from google.  To add one of the results from google, type in its index ID.
7. After adding a book from google to your list, Philo will return your updated list.
8. If you would like to remove a book from your list, simply input 'remove from list' then type the book ID of the title you'd like to remove.
9. The program will return your new list and ask, what you would like to do now. In 'help' to see all options.
10. If you are all set, simply input — 'logout'.

Enjoy! Happy Reading!
