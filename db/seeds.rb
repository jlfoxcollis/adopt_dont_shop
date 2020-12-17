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

app1 = Application.create!(name: "John Fox", street: "2286 Huntington Dr", city: "LHC", state: "AZ", zip_code: 86403, description: "I WANT HIM!", application_status: 1)
app2 = Application.create!(name: "Noooo Fox", street: "2286 Huntington Dr", city: "LHC", state: "AZ", zip_code: 86403, description: "I WANT HIM!")
app3 = Application.create!(name: "YESSS Fox", street: "2286 Huntington Dr", city: "LHC", state: "AZ", zip_code: 86403, description: "I WANT HIM!")
app4 = Application.create!(name: "LEE Fox", street: "2286 Huntington Dr", city: "LHC", state: "AZ", zip_code: 86403, description: "I WANT HIM!")
app5 = Application.create!(name: "James Fox", street: "2286 Huntington Dr", city: "LHC", state: "AZ", zip_code: 86403, description: "I WANT HIM!")
@shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
@shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
@shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
pet1 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
pet2 = @shelter2.pets.create!(image:"puppies.jpeg", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
pet3 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
pet4 = @shelter1.pets.create!(image:"puppies.jpeg", name: "pepper", description: "dog", approximate_age: 6, sex: "male")
pet5 = @shelter1.pets.create!(image:"puppies.jpeg", name: "tucker", description: "dog", approximate_age: 3, sex: "male")
pet6 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Babe", description: "dog", approximate_age: 9, sex: "male")
pet7 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Luna", description: "dog", approximate_age: 2, sex: "male")
pet8 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Rex", description: "dog", approximate_age: 4, sex: "male")
pet9 = @shelter2.pets.create!(image:"puppies.jpeg", name: "Party", description: "cat", approximate_age: 5, sex: "female")
pet10 = @shelter2.pets.create!(image:"puppies.jpeg", name: "Chip", description: "cat", approximate_age: 1, sex: "female")
pet11 = @shelter2.pets.create!(image:"puppies.jpeg", name: "Asshole", description: "cat", approximate_age: 8, sex: "female")
pet12 = @shelter2.pets.create!(image:"puppies.jpeg", name: "Deus", description: "cat", approximate_age: 3, sex: "female")


ApplicationPet.create!(pet_id: pet1.id, application_id: app1.id)
ApplicationPet.create!(pet_id: pet2.id, application_id: app1.id)
ApplicationPet.create!(pet_id: pet3.id, application_id: app1.id)
ApplicationPet.create!(pet_id: pet4.id, application_id: app1.id)
