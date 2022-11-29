class BooksController < ApplicationController
  def new
    @book = Book.new(book_params)
  end
  
  def create
    @book = Book.new(book_params) #createするために空箱用意
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def index
    @book = Book.new #indexを表示するために空箱用意
    @user = current_user
    @books=Book.all
  end

  def show
    #@book = Book.find(params[:id])
  end
  
  def edit
  end
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end
    
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
