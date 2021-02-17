require 'rails_helper'

describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
    it { should have_many :pet_applications }
    it { should validate_presence_of :name }
    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
  end

  describe 'class methods' do
    it 'sets default description and status' do
      app1 = Application.create!(name: "Andrew", street: "123 Main St", city: "Denver", state: "CO", zipcode: "80021")

      expect(app1.description).to eq("Write why you would make a good pet parent")
      expect(app1.status).to eq("In Progress")
    end
  end
end
