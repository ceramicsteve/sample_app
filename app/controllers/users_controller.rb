class UsersController < ApplicationController
before_action :sign_in_user, only: [:index, :edit, :update, :destroy]
before_action :correct_user, only: [:edit, :update]
before_action :admin_user, only: :destroy
#before_action is filter before a call to this controller is used

  def destroy
    user.find(params(:id)).destroy
    flash[:sucess] = "User deleted"
    redirect_to users_url
  end
  def index

    @users = User.paginate(page: params[:page])
    #paginate gem gives this method with has :page as it's parameter

  end

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

  def edit

    #current_user is now passing the @user instance variable before this controller gets called

  end

  def update
    if @user.update_attributes(user_params)
      #current_user is now passing the @user instance variable before this controller gets called
      #user_params is a
      # Handle a sucessful update
     flash[:success] = "Profile updated"
      redirect_to @user
    else
      #if it fails to update it redraws the edit page
      render 'edit'
    end
  end


  private

  def user_params

    params.require(:user).permit(:name, :email, :password, :password_confirmation)
    #instead of using :user which allowed for entire hash of User, we restrict what :user allows to pass on with method user_params

  end
# Before Filters

  def sign_in_user

    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
    #were did signed_in? comform and what's this syntax
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
    #from sessions helper
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
