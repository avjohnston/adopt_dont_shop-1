require 'rails_helper'

RSpec.describe 'Admin application show page' do
  before :each do
    @shelter = Shelter.create(name: "Shelter 1", address: "321 Main St", city: "Denver", state: "CO", zip: "80021")
    @application = Application.create(name: 'Andrew', street: '123 Main St', city: 'Denver', state: 'CO', zipcode: '80021', status: 'In Progress')
    @pet = @shelter.pets.create(name: "Dog", description: "Labrador", approximate_age: 4, sex: :male, adoptable: true)
    @application2 = Application.create(name: 'Andrew2', street: '123 Main St', city: 'Denver', state: 'CO', zipcode: '80021', status: 'In Progress')
    @pet2 = @shelter.pets.create(name: "Frog", description: "Labrador", approximate_age: 4, sex: :male, adoptable: true)
    @application3 = Application.create(name: 'Andrew3', street: '123 Main St', city: 'Denver', state: 'CO', zipcode: '80021', status: 'In Progress')
    @pet3 = @shelter.pets.create(name: "Pupz", description: "Labrador", approximate_age: 4, sex: :male, adoptable: true)
    @application4 = Application.create(name: 'Andrew4', street: '123 Main St', city: 'Denver', state: 'CO', zipcode: '80021', status: 'In Progress')
    @application6 = Application.create(name: 'Andrew6', street: '123 Main St', city: 'Denver', state: 'CO', zipcode: '80021', status: 'In Progress')
    @pet4 = @shelter.pets.create(name: "g-man", description: "Labrador", approximate_age: 4, sex: :male, adoptable: true)
    @application5 = Application.create(name: 'Andrew5', street: '123 Main St', city: 'Denver', state: 'CO', zipcode: '80021', status: 'In Progress')
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
    expect(page).to have_button("Reject This Pet")
    click_on "Approve This Pet"
    expect(current_path).to eq("/admin/applications/#{@application.id}")
  end

  it 'changes application status after all pets are approved' do
    visit "/applications/#{@application.id}"
    fill_in "pet_name", with: "dog"
    click_on "Search Pet By Name"
    click_on "Adopt This Pet"
    fill_in "description", with: "I really want one"
    click_on "Submit Application"
    visit "/admin/applications/#{@application.id}"

    click_on "Approve This Pet"
    expect(current_path).to eq("/admin/applications/#{@application.id}")
    expect(page).to have_content("Status: Approved")
    expect(page).to have_content("#{@pet.name} has been approved!")
    visit "/pets/#{@pet.id}"
    expect(page).to have_content("Adoption Status: false")
  end

  it 'changes application status after all pets are rejected' do
    visit "/applications/#{@application2.id}"
    fill_in "pet_name", with: "frog"
    click_on "Search Pet By Name"
    click_on "Adopt This Pet"
    fill_in "description", with: "I really want one"
    click_on "Submit Application"
    visit "/admin/applications/#{@application2.id}"

    click_on "Reject This Pet"
    expect(current_path).to eq("/admin/applications/#{@application2.id}")
    expect(page).to have_content("Status: Rejected")
    expect(page).to have_content("#{@pet2.name} has been rejected!")
    visit "/pets/#{@pet2.id}"
    expect(page).to have_content("Adoption Status: true")
  end

  it 'changes other applications' do
    visit "/applications/#{@application3.id}"
    fill_in "pet_name", with: "Pupz"
    click_on "Search Pet By Name"
    click_on "Adopt This Pet"
    fill_in "description", with: "I really want one"
    click_on "Submit Application"
    visit "/applications/#{@application4.id}"
    fill_in "pet_name", with: "Pupz"
    click_on "Search Pet By Name"
    click_on "Adopt This Pet"
    fill_in "description", with: "I really want one"
    click_on "Submit Application"
    visit "/admin/applications/#{@application3.id}"
    click_on "Approve This Pet"
    visit "/admin/applications/#{@application4.id}"
    expect(page).to have_content("#{@pet3.name} has already been approved for adoption!")
  end

  it 'rejecting a pet doesnt effect other applications' do
    visit "/applications/#{@application6.id}"
    fill_in "pet_name", with: "g-man"
    click_on "Search Pet By Name"
    click_on "Adopt This Pet"
    fill_in "description", with: "I really want one"
    click_on "Submit Application"
    visit "/applications/#{@application5.id}"
    fill_in "pet_name", with: "g-man"
    click_on "Search Pet By Name"
    click_on "Adopt This Pet"
    fill_in "description", with: "I really want one"
    click_on "Submit Application"
    visit "/admin/applications/#{@application6.id}"
    click_on "Reject This Pet"
    visit "/admin/applications/#{@application5.id}"
    expect(page).to have_button("Approve This Pet")
  end
end
