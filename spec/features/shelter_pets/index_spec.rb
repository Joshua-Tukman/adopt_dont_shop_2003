require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'shelter pets index page' do
    it 'shows all the pets that can be adopted from the shelter with that id' do
      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      shelter2 = Shelter.create(name: "Love Pets",
                                 address: "1111 Dog St.",
                                 city: "Los Angeles",
                                 state: "California",
                                 zip: "90210")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                    name: "Lucille",
                                    age: 3,
                                    sex: "Female")

      george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                    name: "George",
                                    age: 4,
                                    sex: "Male")

      roxy = shelter2.pets.create!(image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fmetro.co.uk%2F2018%2F03%2F09%2Fpit-bulls-banned-uk-7374795%2F&psig=AOvVaw1rkxBBAl4-VTFxhvtSv3mg&ust=1588797005290000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOj-_5rInekCFQAAAAAdAAAAABAO',
                                    name: "Roxy",
                                    age: 2,
                                    sex: "Female")

      visit "/shelters/#{shelter1.id}/pets"

      expect(page).to_not have_content(shelter2.name)

      within "#pet-#{lucille.id}" do
        expect(page).to have_css("img[src*= '#{lucille.image}']")
        expect(page).to have_content(lucille.name)
        expect(page).to have_content(lucille.age)
        expect(page).to have_content(lucille.sex)

        expect(page).to_not have_content(george.name)
        expect(page).to_not have_content(roxy.name)
      end

      within "#pet-#{george.id}" do
        expect(page).to have_css("img[src*= '#{george.image}']")
        expect(page).to have_content(george.name)
        expect(page).to have_content(george.age)
        expect(page).to have_content(george.sex)

        expect(page).to_not have_content(lucille.name)
        expect(page).to_not have_content(roxy.name)
      end
    end

    it 'has a link to create a new pet for that shelter' do

      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")
                                 
      visit "/shelters/#{shelter1.id}/pets"

      click_link "Create Pet"

      expect(current_path).to eq("/shelters/#{shelter1.id}/pets/new")
    end

  end
end
