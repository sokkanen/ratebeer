require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple are returned by the API, they are shown on the page" do
    places = [
        Place.new( name: "Oljenkorsi", id: 1),
        Place.new( name: "Jurrila", id: 2),
        Place.new( name: "Beerhouse", id: 3)
    ]
    allow(BeermappingApi).to receive(:places_in).with("rajis").and_return(places)

    visit places_path
    fill_in('city', with: 'rajis')
    click_button "Search"

    places.each do |place|
        expect(page).to have_content place.name
    end
  end

  it "if nothing is returned by the API, a message is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("vaarala").and_return([])

    visit places_path
    fill_in('city', with: 'vaarala')
    click_button "Search"

    expect(page).to have_content "No locations in vaarala"
  end
end