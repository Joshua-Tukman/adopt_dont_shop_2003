require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'shelters index page' do
    before(:each) do
      @shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      @shelter2 = Shelter.create(name: "Love Pets",
                                 address: "1111 Dog St.",
                                 city: "Los Angeles",
                                 state: "California",
                                 zip: "90210")

      @shelter3 = Shelter.create(name: "Dogs Rock",
                                 address: "Bark Rd.",
                                 city: "Boulder",
                                 state: "Colorado",
                                 zip: "81111")

    end

    it 'can show a list of all the shelters in the system' do

      visit "/shelters"

      within "#shelter-#{@shelter1.id}" do
        expect(page).to have_content("#{@shelter1.name}")
        expect(page).to have_content("#{@shelter1.address}")
        expect(page).to have_content("#{@shelter1.city}")
        expect(page).to have_content("#{@shelter1.state}")
        expect(page).to have_content("#{@shelter1.zip}")

        expect(page).to_not have_content("#{@shelter2.name}")
      end

      within "#shelter-#{@shelter2.id}" do
        expect(page).to have_content("#{@shelter2.name}")
        expect(page).to have_content("#{@shelter2.address}")
        expect(page).to have_content("#{@shelter2.city}")
        expect(page).to have_content("#{@shelter2.state}")
        expect(page).to have_content("#{@shelter2.zip}")

        expect(page).to_not have_content("#{@shelter1.name}")
      end

      within "#shelter-#{@shelter3.id}" do
        expect(page).to have_content("#{@shelter3.name}")
        expect(page).to have_content("#{@shelter3.address}")
        expect(page).to have_content("#{@shelter3.city}")
        expect(page).to have_content("#{@shelter3.state}")
        expect(page).to have_content("#{@shelter3.zip}")

        expect(page).to_not have_content("#{@shelter2.name}")
      end
    end
    it 'has a link to create a new shelter' do

      visit "/shelters"

      click_link "New Shelter"
      expect(current_path).to eq("/shelters/new")
    end
  end
end
