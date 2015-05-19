require 'rails_helper'

feature "create comment" do
  let(:user) { create(:user) }
  let!(:g1) { create(:goal, visibility: "y", user_id: user.id) }
  let!(:g2) { create(:goal, visibility: "n", user_id: user.id) }
  before(:each) do
    visit new_user_url
    sign_in_as(user)
  end
  it ""
end
