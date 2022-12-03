class BooksController < ApplicationController
  before_action :is_mathing_login_user, only: [:edit]

  def new
    @book = Book.new(book_params)
  end
  
  def create
    @user = current_user
    @books=Book.all
    @book = Book.new(book_params) #createするために空箱用意
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
    else
    render :index #viewページのこと
    end
  end

  def index
    @book = Book.new #create用の空箱
    @user = current_user
    @books=Book.all
  end

  def show
    @book = Book.new #create用の空箱
    @book_id = Book.find(params[:id]) #投稿を並べる用
    @user = @book_id.user
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
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
  
  def is_mathing_login_user
    book = Book.find(params[:id])
    user_id = book.user.id
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end
  
end