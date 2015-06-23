require 'rails_helper'

feature "create comment" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:user_goal) { create(:goal, visibility: "y", user_id: user.id) }

  before(:each) do
    visit new_session_url
    sign_in_as(other_user)
    visit user_url(user)
  end

  it "allows users to comment on users" do
    fill_in "User Comment", with: "Fun user!"
    click_on "Comment on user"

    expect(page).to have_content user_goal.body
    expect(page).to have_content "Fun user!"
  end

  it "allows users to comment on goals" do
    fill_in "Goal Comment", with: "Fun goal!"
    click_on "Comment on goal"

    expect(page).to have_content user_goal.body
    expect(page).to have_content "Fun goal!"
  end
end
