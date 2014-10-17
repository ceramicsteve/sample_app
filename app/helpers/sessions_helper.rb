module SessionsHelper

#Shit i don't understand yet

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token ] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

def signed_in?
  !current_user.nil?
  #is false if current_user is not assigned
end

 def current_user=(user)
# defines current_user= to be able to update the value of user the variable is current_user=
# attr_accessor declaration could be used
  @current_user = user
end

def current_user
  remember_token = User.digest(cookies[:remember_token])

  @current_user ||= User.find_by(remember_token: remember_token)
end

def current_user?(user)

  user == current_user
  # if user hash == current_user hash return true

end

  def sign_out
    current_user.update_attribute(:remember_token,User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  # session is a rails method that temporary saves the requested url location

  def redirect_back_or(default)
    redirect_to(session[:return_to]|| default)
    #return_to method stores the requested url or if false returns to root
    session.delete(:return_to)
    #deletes the requested url
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

end
