require 'rails_helper'

RSpec.describe 'Application new page' do
  it 'has fields to enter information' do
    visit 'applications/new'

    expect(page).to have_content("Name")
    fill_in "name", with: "Human"
    expect(page).to have_content("Street")
    fill_in "street", with: "123 Main St"
    expect(page).to have_content("City")
    fill_in "city", with: "Denver"
    expect(page).to have_content("State")
    fill_in "state", with: "CO"
    expect(page).to have_content("Zipcode")
    fill_in "zipcode", with: "80021"
    click_on "Submit Application"
    expect(current_path).to_not eq("/applications/new")
  end
end
