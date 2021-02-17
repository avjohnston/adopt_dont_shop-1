require 'rails_helper'

RSpec.describe 'Admin application index page' do
  before :each do
    @application = Application.create(name: 'Andrew', street: '123 Main St', city: 'Denver', state: 'CO', zipcode: '80021', status: 'In Progress')
    @shelter = Shelter.create(name: "Shelter 1", address: "321 Main St", city: "Denver", state: "CO", zip: "80021")
    @pet = @shelter.pets.create(name: "Dog", description: "Labrador", approximate_age: 4, sex: :male, adoptable: true)
  end

  it 'admin index shows all applications' do
    visit "admin/applications"

    expect(page).to have_link("Andrew")
    expect(page).to have_content("Address: 123 Main St, Denver, CO 80021")
    expect(page).to have_content("Status: #{@application.status}")
    click_link "Andrew"
    expect(current_path).to eq("/admin/applications/#{@application.id}")
  end

end
