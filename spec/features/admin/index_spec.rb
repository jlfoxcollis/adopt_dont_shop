require 'rails_helper'

RSpec.describe 'lists all shelters and apps' do
  before :each do
    @app = Application.create!(name: "James Fox", street: "2286 Huntington Dr", city: "LHC", state: "AZ", zip_code: 86403, description: "I WANT HIM!")
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
    @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
    @pet1 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter2.pets.create!(image:"puppies.jpeg", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
    @pet_app1 = ApplicationPet.create!(pet_id: @pet1.id, application_id: @app.id)
    @pet_app2 = ApplicationPet.create!(pet_id: @pet2.id, application_id: @app.id)
    @app.update({application_status: "Pending"})
  end

  it " lists shelters and applications" do
    visit admin_path

    expect(page).to have_content("#{@shelter1.name}")
    expect(page).to have_content("#{@shelter3.name}")
    expect(page).to have_content("#{@shelter2.name}")
    expect(page).to have_content(" #{@app.id}")
  end
end
