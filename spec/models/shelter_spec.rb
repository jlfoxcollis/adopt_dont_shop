require 'rails_helper'

describe Shelter, type: :model do
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
  describe 'relationships' do
    it { should have_many :pets }
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe 'instance methods' do
    it "can return avg_pet_age" do

      expect(@shelter1.avg_pet_age).to eq(3)
    end

    it "can count pending_pets" do
      expect((@shelter1.pending_pets).length).to eq(0)

      @app.update({application_status: "Pending"})

      expect((@shelter1.pending_pets).length).to eq(1)
    end

    it "can count adoptables" do

      expect(@shelter1.pet_count(true)).to eq(2)
      expect(@shelter2.pet_count(true)).to eq(1)
    end

    it 'can count adopted' do

      expect(@shelter1.pet_count(false)).to eq(0)

      @pet1.update({adoptable: false})
      expect(@shelter1.pet_count(false)).to eq(1)
      expect(@shelter1.pet_count(true)).to eq(1)
    end
  end

  describe "class methods/scopes" do
    it "can organize shelters" do

      expect(Shelter.admin_shelter).to eq([@shelter2, @shelter3, @shelter1])
    end

    it "can scope out pending_apps" do

      expect(Shelter.pending_apps).to eq([])

      @app.update!({application_status: "Pending"})
      expect((Shelter.pending_apps).length).to eq(2)
    end

    it "can destroy" do

      expect(Shelter.count).to eq(3)
      Shelter.destroy(@shelter1.id)
      expect(Shelter.count).to eq(2)
    end
  end
end
