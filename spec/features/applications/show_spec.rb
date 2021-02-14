require 'rails_helper'

RSpec.describe 'Application show page' do
  before :each do
    @application = Application.create(name: 'Andrew', street: '123 Main St', city: 'Denver', state: 'CO', zipcode: '80021', status: 'In Progress')
    @shelter = Shelter.create(name: "Shelter 1", address: "321 Main St", city: "Denver", state: "CO", zip: "80021")
    @pet = @shelter.pets.create(name: "Dog", description: "Labrador", approximate_age: 4, sex: :male, adoptable: true)
  end

  it 'show page has application info' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("Applicant: #{@application.name}")
    expect(page).to have_content("Address: 123 Main St, Denver, CO 80021")
    expect(page).to have_content("Status: #{@application.status}")
  end

  it 'has pet search' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("Add A Pet To This Application")
    fill_in "pet_name", with: "dog"
    click_on "Search Pet By Name"
    expect(page).to have_content("Dog")
    expect(page).to have_content("Male")
    expect(page).to have_content("4")
    expect(page).to have_content("Labrador")
    expect(page).to have_content("True")

    click_on "Adopt This Pet"
    expect(current_path).to eq("/applications/#{@application.id}")
    expect(page).to have_content("Pets: Dog")

    expect(page).to have_content("Description")
    fill_in "description", with: "I really want one"
    click_on "Submit Application"

    expect(current_path).to eq("/applications/#{@application.id}")
    expect(page).to have_content("Status: Pending")
    expect(page).to have_content("Description: I really want one")
  end

end
