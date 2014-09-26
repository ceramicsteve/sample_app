include ApplicationHelper

def valid_signin(user, options={} )
if options[:no_capybara]
  # Sign in when not using Capybara
  remember_token = User.new_remember_token
  cookies[:remember_token] = remember_token
  user.update_attribute(:remember_token, User.digest(remember_token))
else

  visit signin_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"

  end
end

Rspec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alarm.alarm-error', text: message)
  end
end

