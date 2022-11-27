require 'rails_helper'

describe "Places" do

  before :each do
    mock_weather = {
      "observation_time"=>"10:01 PM",                                                          
      "temperature"=>10,                                                                       
      "weather_code"=>296,                                                                     
      "weather_icons"=>["https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0033_cloudy_with_light_rain_night.png"],
      "weather_descriptions"=>["Light Rain, Mist"],                                            
      "wind_speed"=>13,                                                                        
      "wind_degree"=>190,                                                                      
      "wind_dir"=>"S",                                                                         
      "pressure"=>1001,                                                                        
      "precip"=>0,                                                                             
      "humidity"=>89,
      "cloudcover"=>100,
      "feelslike"=>8,
      "uv_index"=>1,
      "visibility"=>6,
      "is_day"=>"no"
    }
    allow(WeatherstackApi).to receive(:weather_in).with("kumpula").and_return(mock_weather)
    allow(WeatherstackApi).to receive(:weather_in).with("rajis").and_return(mock_weather)
    allow(WeatherstackApi).to receive(:weather_in).with("vaarala").and_return(mock_weather)
  end

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