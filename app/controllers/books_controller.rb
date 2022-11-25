class BooksController < ApplicationController
  def new
    @book = Book.new(book_params)
  end

  def index
  end

  def show
  end
  
  def edit
  end
end
