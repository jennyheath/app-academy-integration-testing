require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
    expect(page).to have_field "Username"
    expect(page).to have_field "Password"
  end

  feature "signing up a user" do
    it "shows username on the homepage after signup" do
      user = build(:user)
      sign_up_as(user)

      expect(page).to have_content user.username
      expect(page).to have_content "Your Goals"
    end

    it "validates presence of username" do
      user = build(:user, username: nil)
      sign_up_as(user)

      expect(page).to have_content "Username can't be blank"
    end

    it "validates length of password" do
      user = build(:user, password: nil)
      visit new_user_url
      fill_in 'Username', with: user.username
      fill_in 'Password', with: "lol"
      click_on "Sign Up"

      expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end

    it "validates username uniqueness" do
      user = create(:user)
      sign_in_as(user)
      click_button "Sign Out"
      visit new_user_url
      fill_in 'Username', with: user.username
      click_on "Sign Up"

      expect(page).to have_content "Username has already been taken"
    end
  end

end

feature "logging in" do

  it "shows username on the homepage after login" do
    user = create(:user)
    sign_in_as(user)

    expect(page).to have_content user.username
    expect(page).to have_content "Your Goals"
  end

end

feature "logging out" do

  it "begins with logged out state" do
    visit new_session_url

    expect(page).to have_content("Sign In")
  end

  it "doesn't show username on the homepage after logout" do
    user = create(:user)
    sign_in_as(user)
    click_on "Sign Out"

    expect(page).to have_content("Sign In")
  end

end
