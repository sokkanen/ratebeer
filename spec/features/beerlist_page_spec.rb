require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new app, :browser => :chrome
        #options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
    end
    WebMock.allow_net_connect!
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schelenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows one known beer", js:true do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
  end

  it "beers are sorted in the default order", js:true do
    expected_beers = ["Fastenbier", "Lechte Weisse", "Nikolai"]
    visit beerlist_path
    table = find('#beertable').all('.tablerow')
    table.each_with_index do |row, index|
        expect(row.text).to have_content expected_beers[index]
    end
  end

  it "beers are sorted by style when the row is clicked", js:true do
    expected_styles = ["Lager", "Rauchbier", "Weizen"]
    visit beerlist_path
    find('#beertable').all('.tablerow')
    execute_script("document.querySelector('#style').click()")
    table = find('#beertable').all('.tablerow')
    table.each_with_index do |row, index|
      expect(row.text).to have_content expected_styles[index]
    end
  end

  it "beers are sorted by brewery when the row is clicked", js:true do
    expected_breweries = ["Ayinger", "Koff", "Schelenkerla"]
    visit beerlist_path
    find('#beertable').all('.tablerow')
    execute_script("document.querySelector('#brewery').click()")
    table = find('#beertable').all('.tablerow')
    table.each_with_index do |row, index|
      expect(row.text).to have_content expected_breweries[index]
    end
  end
end