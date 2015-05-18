module AuthHelpers
  def sign_in_as(user)
    visit new_session_url
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_on "Sign In"
  end

  def sign_up_as(user)
    visit new_user_url
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_on "Sign Up"
  end
end
