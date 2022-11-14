require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "with erroneous properties" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    it "is not saved without a name" do
      beer = Beer.create style: "teststyle", brewery: test_brewery

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "is not saved without a style" do
      beer = Beer.create name: "testlager", brewery: test_brewery

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
  describe "with a proper attributes" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }

    it "is saved" do
      beer = Beer.create style: "teststyle", brewery: test_brewery, name: "testbeer"

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end
end