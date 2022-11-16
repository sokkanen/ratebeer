require 'rails_helper'

describe "Beers page" do
  let!(:user) { FactoryBot.create :user }
  it "should not have any before been created" do
    visit beers_path
    expect(page).to have_content 'Beers'
    expect(page).to have_content 'Number of beers: 0'

  end

  describe "Adding a new beer" do
    before :each do
      @breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896
      @breweries.each do |brewery_name|
        FactoryBot.create(:brewery, name: brewery_name, year: year += 1)
      end
      sign_in(username: "Pekka", password: "Foobar1")
      visit beers_path
    end

    it "should succeed with a proper name" do
      click_link "New beer"
      fill_in('beer_name', with: 'Testibisse')
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

    it "should not succeed with an inproper name" do
      click_link "New beer"
      fill_in('beer_name', with: '')
      click_button('Create Beer')
      expect(page).to have_content 'Name can\'t be blank'
    end

  end
end