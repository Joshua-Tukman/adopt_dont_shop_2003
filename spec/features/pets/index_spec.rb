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
                                     status: false,
                                     sex: "female")

      george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                     name: "George",
                                     age: 4,
                                     status: false,
                                     sex: "Male")

       bob = shelter1.pets.create!(image: 'https://i.ytimg.com/vi/8FCSw-ST8hA/maxresdefault.jpg',
                                     name: "Bob",
                                     description: "Handsome Pug!",
                                     age: 2,
                                     sex: "male")

       gladys = shelter1.pets.create!(image: 'https://static.ddmcdn.com/en-us/apl/breedselector/images/breed-selector/dogs/breeds/dachshund-standard_01_lg.jpg',
                                     name: "Gladys",
                                     description: "A total terror!",
                                     age: 4,
                                     sex: "female")

       maceo = shelter1.pets.create!(image: 'https://upload.wikimedia.org/wikipedia/commons/0/00/1._DSC_0346_%2810096362833%29.jpg',
                                     name: "Maceo Parker",
                                     age: 10,
                                     description: "Best damn dog around!",
                                     sex: "male")

       charlie = shelter1.pets.create!(image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ9IcR0ehgkAEqxBilz3GgsoQDLynWZILEPbmHQRPUrrdU0kXKV&usqp=CAU',
                                     name: "Charles",
                                     age: 6,
                                     description: "Your new best friend",
                                     sex: "male")

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

    it 'has a link next to each pet where I can edit the pet' do

      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                     name: "Lucille",
                                     age: 3,
                                     sex: "female")

      george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                     name: "George",
                                     age: 4,
                                     sex: "Male")

      visit "/pets"

      within "#pet-#{lucille.id}" do
        expect(page).to have_css("img[src*= '#{lucille.image}']")
        click_link "Edit Pet"
      end

      expect(current_path).to eq("/pets/#{lucille.id}/edit")

      fill_in :image, with: "https://www.petmd.com/sites/default/files/Pit-Bull-Dog-Facts-1168732600_0.jpg"

      click_button "Update Pet"

      expect(current_path).to eq("/pets/#{lucille.id}")
      expect(page).to have_css("img[src*= 'https://www.petmd.com/sites/default/files/Pit-Bull-Dog-Facts-1168732600_0.jpg']")

    end

    it 'has a link next to each pet to delete that pet' do
      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                     name: "Lucille",
                                     age: 3,
                                     sex: "female")

      george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                     name: "George",
                                     age: 4,
                                     sex: "Male")
                                     visit "/pets"

      within "#pet-#{lucille.id}" do
       expect(page).to have_css("img[src*= '#{lucille.image}']")
        click_link "Delete Pet"
      end

      expect(current_path).to eq("/pets")
      expect(page).to_not have_css("img[src*= '#{lucille.image}']")
     end

     it 'will display all of the adoptable pets before the pets with pending status' do
       shelter1 = Shelter.create(name: "Pet House",
                                  address: "12 Main St.",
                                  city: "Denver",
                                  state: "Colorado",
                                  zip: "80001")

       lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                      name: "Lucille",
                                      age: 3,
                                      status: false,
                                      sex: "female")

       george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                      name: "George",
                                      age: 4,
                                      sex: "Male",
                                      status: false)

       maceo = shelter1.pets.create!(image: 'https://upload.wikimedia.org/wikipedia/commons/0/00/1._DSC_0346_%2810096362833%29.jpg',
                                     name: "Maceo Parker",
                                     age: 10,
                                     description: "Best damn dog around!",
                                     sex: "male")

       charlie = shelter1.pets.create!(image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ9IcR0ehgkAEqxBilz3GgsoQDLynWZILEPbmHQRPUrrdU0kXKV&usqp=CAU',
                                     name: "Charles",
                                     age: 6,
                                     description: "Your new best friend",
                                     sex: "male")

       visit "/pets"
     end

     it 'has a link to change the adoptable status to pending' do
       shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

       lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                       name: "Lucille",
                                       age: 3,
                                       status: true,
                                       description: "Lovable pitbull",
                                       sex: "female")

       visit "/pets"

       within "#pet-#{lucille.id}" do
         expect(lucille.adoptable_status).to eq("Adoptable!")
         click_link "Adopt this Pet!"
       end
       lucille.reload
       expect(current_path).to eq("/pets/#{lucille.id}")
       expect(lucille.adoptable_status).to eq("Pending")
     end
  end
end
