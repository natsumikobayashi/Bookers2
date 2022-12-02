class UsersController < ApplicationController
  before_action :is_mathing_login_user, only: [:edit]
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
    
  end
  
  def edit
    @user = User.find(params[:id])
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
    
  end
  
  def index
    @book = Book.new #create用の空箱
    @user = current_user
    @users = User.all
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_mathing_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
     redirect_to user_path
    end
  end
  
end