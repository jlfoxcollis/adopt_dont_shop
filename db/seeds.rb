# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Application.destroy_all
Shelter.destroy_all
Pet.destroy_all


Application.create!(name: "James Fox", street: "2286 Huntington Dr", city: "LHC", state: "AZ", zip_code: 86403, description: "I WANT HIM!")
@shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
@shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
@shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
@shelter1.pets.create!(image:"puppies.jpeg", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
@shelter2.pets.create!(image:"puppies.jpeg", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
@shelter1.pets.create!(image:"puppies.jpeg", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
