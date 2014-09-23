class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) #creates @user with find parameter of :id
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user #creates the sign in page
      flash[:success] = "Welcome to the Sample App!"
     redirect_to @user #Sucess redirects to user page
    else
      render 'new' #render refreshes page
    end
  end

  def new

    @user = User.new

  end

  private #private code?

  def user_params

    params.require(:user).permit(:name, :email, :password, :password_confirmation)
    #instead of using :user which allowed for entire hash of User, we restrict what :user allows to pass on with method user_params

  end
end
