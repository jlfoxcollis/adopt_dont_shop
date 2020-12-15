require 'rails_helper'

describe 'admin_apps show page' do
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

  it "displays  the applicant information" do
    visit "/admin/applications/#{@app.id}"

    expect(page).to have_content("#{@app.name}")

    expect(page).to have_content("#{@pet1.name}")
  end

  it "can update pets on application" do
    visit admin_application_path(@app.id)
    
    within("#accept-#{@pet1.id}") do
      click_on "Approve"
    end
    expect(page).to have_content("Approved!")

    within("#accept-#{@pet2.id}") do
      click_on "Approve"
    end

    expect(page).to have_content("Application for Adoption has been Approved!")
  end

  it "can reject application" do
    @pet_app1.update({status: true})
    @pet_app2.update({status: false})
    visit "/admin/applications/#{@app.id}"


    expect(page).to have_content("We regret to inform you that your home is not good enough for our pets.")
  end
end
