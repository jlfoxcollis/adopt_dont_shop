require 'rails_helper'

RSpec.describe 'admin shelters index' do
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
  end

  it "can can show an app page progress" do
    visit application_path(@app.id)

    expect(page).to have_content("In Progress")
    @app.update({application_status: "Pending"})
    visit application_path(@app.id)
    expect(page).to have_content("Pending")
  end

  it "can search for pets" do
    visit application_path(@app.id)

    fill_in 'search', with: "Thor"

    click_on "search"
    expect(page).to have_content("Thor")
    click_on "Adopt this Pet?"
    click_on "Submit Application"

  end
end
