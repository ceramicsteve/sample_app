class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email].downcase)

    # Session Class passes
    #               email
    #               password
    #session is a hash when passing the params to user you have to list
    #which part of the hash to pass
    # session: { password: " ", email: " "}
    # if we do params [:session][:email]

    if user && user.authenticate(params[:password])

      # Sign the user in and redirect to the user's show page

      session[:user_id] = user.id

      # capturing the user_id string in the session database and
      # passing it to the user class with the session's ID
      # by passing the declarations needed in the create method

      sign_in user

      #sign_in(user) from session_helper is used here

      redirect_back_or user

      #sends user back to original url it logged in from
    else
      flash.now[:error] = 'Invalid email/password combination' #not quite right!
      render 'new'
    end

  end

  def new

  end

  def destroy
    sign_out
    redirect_to root_url

  end
end
