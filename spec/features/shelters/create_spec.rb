require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'new page' do
    it 'can create a new shelter in the system' do

      visit 'shelters/new'

      fill_in :name, with: "Best Companions"
      fill_in :address, with: "131 Pit Bull Lane"
      fill_in :city, with: "Boston"
      fill_in :state, with: "Massachusetts"
      fill_in :zip, with: "01010"
      click_on "Create Shelter"

      shelter = Shelter.last

      expect(current_path).to eq("/shelters")
      expect(page).to have_content(shelter.name)
    end
  end
end
