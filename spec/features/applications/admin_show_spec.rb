require 'rails_helper'

RSpec.describe 'Admin application show page' do
  before :each do
    @application = Application.create(name: 'Andrew', street: '123 Main St', city: 'Denver', state: 'CO', zipcode: '80021', status: 'In Progress')
    @shelter = Shelter.create(name: "Shelter 1", address: "321 Main St", city: "Denver", state: "CO", zip: "80021")
    @pet = @shelter.pets.create(name: "Dog", description: "Labrador", approximate_age: 4, sex: :male, adoptable: true)
  end

  it 'shows admin applications' do
    visit "/applications/#{@application.id}"
    fill_in "pet_name", with: "dog"
    click_on "Search Pet By Name"
    click_on "Adopt This Pet"
    fill_in "description", with: "I really want one"
    click_on "Submit Application"

    visit "/admin/applications/#{@application.id}"

    expect(page).to have_content("Applicant: #{@application.name}")
    expect(page).to have_content("Address: 123 Main St, Denver, CO 80021")
    expect(page).to have_content("Status: Pending")
    expect(page).to have_button("Approve This Pet")
    click_on "Approve This Pet"
    expect(current_path).to eq("/admin/applications/#{@application.id}")
  end
end
