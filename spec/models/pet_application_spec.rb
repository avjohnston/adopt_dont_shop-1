require 'rails_helper'

describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to :pet }
    it { should belong_to :application }
  end

  describe 'class methods' do
    it 'has a default approved of none' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      app1 = Application.create!(name: "Andrew", street: "123 Main St", city: "Denver", state: "CO", zipcode: "80021")
      pet_app = PetApplication.create!(application: app1, pet: pet)
      app1.update(description: "Please", status: "Pending")

      expect(pet_app.approved).to eq("none")
    end
  end
end
