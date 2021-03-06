include ApplicationHelper

  def valid_signin(user)
   fill_in       "Email",    with: user.email
   fill_in       'Password', with: user.password
   click_button  "Sign in"
  end

  def sign_in(user)
   visit signin_url
   fill_in "Email", with: user.email
   fill_in "Password", with: user.password
   click_button "Sign in"
   #Sign in when not using Capybara as well.
   cookies[:remember_token] = user.remember_token
  end
