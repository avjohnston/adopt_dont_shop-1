require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
  end

  describe 'methods' do
    it 'can find shelters with pending apps' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      app1 = Application.create!(name: "Andrew", street: "123 Main St", city: "Denver", state: "CO", zipcode: "80021")
      PetApplication.create!(application: app1, pet: pet)
      app1.update(description: "Please", status: "Pending")

      expect(Shelter.pending_apps).to eq([shelter])
    end

    it 'can find average pet age' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 5, description: 'super cute')
      app1 = Application.create!(name: "Andrew", street: "123 Main St", city: "Denver", state: "CO", zipcode: "80021")
      PetApplication.create!(application: app1, pet: pet)
      app1.update(description: "Please", status: "Pending")


      expect(shelter.average_pet_age).to eq(4)
    end

    it 'can find adopted pets' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      pet2 = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 5, description: 'super cute')
      app1 = Application.create!(name: "Andrew", street: "123 Main St", city: "Denver", state: "CO", zipcode: "80021")
      PetApplication.create!(application: app1, pet: pet)
      app1.update(description: "Please", status: "Pending")


      expect(shelter.adopted_pets).to eq(0)
    end

    it 'can find adoptable pets' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      pet2 = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 5, description: 'super cute')
      app1 = Application.create!(name: "Andrew", street: "123 Main St", city: "Denver", state: "CO", zipcode: "80021")
      PetApplication.create!(application: app1, pet: pet)
      app1.update(description: "Please", status: "Pending")

      expect(shelter.adoptable_pets).to eq(2)
    end

    it 'can find adoptable pets' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      pet2 = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 5, description: 'super cute')
      app1 = Application.create!(name: "Andrew", street: "123 Main St", city: "Denver", state: "CO", zipcode: "80021")
      PetApplication.create!(application: app1, pet: pet)
      PetApplication.create!(application: app1, pet: pet2)
      app1.update(description: "Please", status: "Pending")


      expect(shelter.action_pets).to eq([pet, pet2])
    end
  end
end
