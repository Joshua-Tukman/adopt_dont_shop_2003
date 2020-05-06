require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'pets index page' do
    it 'shows a list of each pet in the system along with their information' do
      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                     name: "Lucille",
                                     age: 3,
                                     sex: "Female")

      george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                     name: "George",
                                     age: 4,
                                     sex: "Male")

      visit "/pets"

      within "#pet-#{lucille.id}" do
        expect(page).to have_css("img[src*= '#{lucille.image}']")
        expect(page).to have_content(lucille.name)
        expect(page).to have_content(lucille.sex)
        expect(page).to have_content(lucille.age)

        expect(page).to_not have_content(george.name)
      end

      within "#pet-#{george.id}" do
        expect(page).to have_css("img[src*= '#{george.image}']")
        expect(page).to have_content(george.name)
        expect(page).to have_content(george.sex)
        expect(page).to have_content(george.age)

        expect(page).to_not have_content(lucille.name)
      end
    end
  end
end
