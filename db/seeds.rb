# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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

shelter3 = Shelter.create(name: "Dogs Rock",
                           address: "Bark Rd.",
                           city: "Boulder",
                           state: "Colorado",
                           zip: "81111")

lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                              name: "Lucille",
                              age: 9,
                              sex: "Female",
                              description: "Lovable Pitbull")

george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                              name: "George",
                              age: 4,
                              sex: "Male")
