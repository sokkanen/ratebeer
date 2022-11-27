require 'rails_helper'

include Helpers

describe "User" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:user) { FactoryBot.create :user, username: 'Kimmo' }
  let!(:user2) { FactoryBot.create :user, username: "Keijo" }
  before :each do
    @rating1 = FactoryBot.create(:rating, score: 20, beer: beer1, user: user)
    FactoryBot.create(:rating, score: 15, beer: beer1, user: user)
    FactoryBot.create(:rating, score: 25, beer: beer1, user: user2)
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Kimmo", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Kimmo'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Kimmo", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', with: 'Brian')
      fill_in('user_password', with: 'Secret55')
      fill_in('user_password_confirmation', with: 'Secret55')
    
      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end

    it "individual page shows only user's own ratings" do
      sign_in(username: "Kimmo", password: "Foobar1")
      expect(page).to have_content 'Has made 2 ratings, average rating 17.5.'
      expect(page).to have_content 'iso 3 15'
      expect(page).to have_content 'iso 3 20'
      expect(page).not_to have_content 'iso 3 25'
    end

    it "individual page shows user's favorite style and brewery" do
      sign_in(username: "Kimmo", password: "Foobar1")
      expect(page).to have_content 'Favorite style: Test style'
      expect(page).to have_content 'Favorite brewery: Koff'
    end

    it "removing rating removes it from the database" do
      Capybara.default_max_wait_time = 5
      sign_in(username: "Kimmo", password: "Foobar1")
      expect{
        page.find_by_id("delete_rating_#{@rating1.id}").click
      }.to change{Rating.count}.by(-1)
    end
  end
end