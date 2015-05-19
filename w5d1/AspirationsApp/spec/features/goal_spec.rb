require 'rails_helper'

context "when signed in" do
  let(:user) { create(:user) }
  let!(:g1) { create(:goal, visibility: "y", user_id: user.id) }
  let!(:g2) { create(:goal, visibility: "n", user_id: user.id) }
  before(:each) do
    visit new_user_url
    sign_in_as(user)
  end

  feature "goal creation" do

    it "has create goal form on user show page" do
      expect(page).to have_field "Goal"
    end

    it "allows user to create a new goal" do
      fill_in "Goal", with: "A fun new goal! (brush teeth)"
      click_on "Submit Goal"
      expect(page).to have_content "Your Goals"
    end

  end

  feature "goal display and manipulation" do


    context "displaying goals" do

      it "displays all of a user's own goals" do
        # visit(current_path)
        expect(page).to have_content g1.body
        expect(page).to have_content g2.body
      end

      it "does not show other users' private goals" do
        click_on "Sign Out"
        other_user = build(:user)
        sign_up_as(other_user)
        visit user_url(user)

        expect(page).to have_content g1.body
      end

    end

    context "updating goals" do

      it "has a link to update each goal" do
        expect(page).to have_content "Update Goal"
      end

      it "allows user to update a goal" do
        click_on "Update Goal", match: :first
        expect(page).to have_field "Goal"
        fill_in "Goal", with: "Updated Goal"
        click_on "Update Goal"

        expect(page).to have_content "Your Goals"
        expect(page).to have_content "Updated Goal"
      end
    end
  end

  feature "checking off goals" do
    let(:goal) { create_public_goal }

    it "allows user to show when goal has been completed" do
      click_button "Completed", match: :first
      expect(page).to_not have_content goal.body
    end
  end
end


  context "when not signed in" do

    it "redirects to new session url" do
      user = create(:user)
      visit user_url(user)
      expect(page).to have_content "Sign In"
      expect(page).to have_field "Username"
      expect(page).to have_field "Password"
    end
  end
