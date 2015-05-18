require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
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
      user = build(:nil_user)
      sign_up_as(user)

      expect(page).to have_content "Username can't be blank"
    end

    it "validates presence of password" do
      user = build(:nil_password)
      sign_up_as(user)

      expect(page).to have_content "Password can't be blank"
    end

    it "validates presence of password" do
      user = build(:nil_password)
      visit new_user_url
      fill_in 'username', with: user.username
      fill_in 'password', with: "lol"
      click_on "Sign Up"

      expect(page).to have_content "Password too short: minimum 6 letters"
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
