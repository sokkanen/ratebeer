require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
    FactoryBot.create(:rating, score: 20, beer: beer1, user: user)
    FactoryBot.create(:rating, score: 25, beer: beer1, user: user)
    FactoryBot.create(:rating, score: 10, beer: beer2, user: user)
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(3).to(4)

    expect(user.ratings.count).to eq(4)
    expect(beer1.ratings.count).to eq(3)
    expect(beer1.average_rating).to eq(20.0)
  end

  it "number of ratings if shown on the page" do
    visit ratings_path
    expect(page).to have_content 'Ratings'
    expect(page).to have_content 'Total number of ratings: 3'
  end
end