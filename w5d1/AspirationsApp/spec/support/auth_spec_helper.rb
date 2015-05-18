module AuthHelpers
  def sign_in_as(user)
    visit new_session_url
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on "Sign In"
  end

  def sign_up_as(user)
    visit new_user_url
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on "Sign Up"
  end
end
