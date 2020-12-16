require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many(:applications).through(:application_pets)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :sex}
    it {should validate_numericality_of(:approximate_age).is_greater_than_or_equal_to(0)}

    it 'is created as adoptable by default' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(true)
    end

    it 'can be created as not adoptable' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(adoptable: false, name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(false)
    end

    it 'can be male' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :male, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('male')
      expect(pet.male?).to be(true)
      expect(pet.female?).to be(false)
    end

    it 'can be female' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('female')
      expect(pet.female?).to be(true)
      expect(pet.male?).to be(false)
    end
  end

  describe "scopes/class methods" do
    it "is adoptable" do
      app = Application.create!(name: "James Fox", street: "2286 Huntington Dr", city: "LHC", state: "AZ", zip_code: 86403, description: "I WANT HIM!")
      @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
      @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
      @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
      @pet1 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
      @pet2 = @shelter2.pets.create!(image:"puppies.jpeg", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
      @pet3 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
      pet_app1 = ApplicationPet.create!(pet_id: @pet1.id, application_id: app.id)
      pet_app2 = ApplicationPet.create!(pet_id: @pet2.id, application_id: app.id)

      expect(Pet.adoptable).to eq([@pet1, @pet2, @pet3])
    end

    it "can search names" do
      app = Application.create!(name: "James Fox", street: "2286 Huntington Dr", city: "LHC", state: "AZ", zip_code: 86403, description: "I WANT HIM!")
      @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
      @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
      @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
      @pet1 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
      @pet2 = @shelter2.pets.create!(image:"puppies.jpeg", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
      @pet3 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
      pet_app1 = ApplicationPet.create!(pet_id: @pet1.id, application_id: app.id)
      pet_app2 = ApplicationPet.create!(pet_id: @pet2.id, application_id: app.id)
      app.update!({application_status: 1})

      expect(Pet.search_pets(@pet1.name)).to eq([@pet1])
    end
  end

  describe "Instance methods" do
    it "can count apps_approved" do
      app = Application.create!(name: "James Fox", street: "2286 Huntington Dr", city: "LHC", state: "AZ", zip_code: 86403, description: "I WANT HIM!")
      @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
      @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
      @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
      @pet1 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
      @pet2 = @shelter2.pets.create!(image:"puppies.jpeg", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
      @pet3 = @shelter1.pets.create!(image:"puppies.jpeg", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
      pet_app1 = ApplicationPet.create!(pet_id: @pet1.id, application_id: app.id)
      pet_app2 = ApplicationPet.create!(pet_id: @pet2.id, application_id: app.id)

      expect(@pet1.none_approved?).to eq(true)
      pet_app1.update!({status: true})
      expect(@pet1.none_approved?).to eq(false)
    end
  end


end
