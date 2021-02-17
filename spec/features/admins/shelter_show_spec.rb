require 'rails_helper'

RSpec.describe 'Admin shelter show page' do
  before :each do
    @shelter = Shelter.create!(name: "Zoo", address: "456 Main St", city: "Denver", state: "CO", zip: "80021")
    @shelter2 = Shelter.create!(name: "Pet Adoption", address: "755 Main St", city: "Denver", state: "CO", zip: "80021")
    @shelter3 = Shelter.create!(name: "We Sell Pets", address: "755 Main St", city: "Denver", state: "CO", zip: "80021")
    @shelter4 = Shelter.create!(name: "Dog Palace", address: "755 Main St", city: "Denver", state: "CO", zip: "80021")

    @app1 = Application.create!(name: "Andrew", street: "123 Main St", city: "Denver", state: "CO", zipcode: "80021")
    @app2 = Application.create!(name: "Khoa", street: "321 Broadway St", city: "Denver", state: "CO", zipcode: "80021")
    @app3 = Application.create!(name: "Jake", street: "321 Baseline St", city: "Denver", state: "CO", zipcode: "80021")
    @app4 = Application.create!(name: "Doug", street: "321 Arapahoe St", city: "Denver", state: "CO", zipcode: "80021")

    @buddy = @shelter.pets.create!(image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/20113314/Carolina-Dog-standing-outdoors.jpg", name: "Buddy", approximate_age: 4, description: "Doggy", adoptable: true, sex: :male)
    @fluffy = @shelter.pets.create!(image: "https://ei.marketwatch.com/Multimedia/2020/04/09/Photos/ZQ/MW-IE203_corona_20200409232441_ZQ.jpg?uuid=d12f4334-7ada-11ea-b13a-9c8e992d421e", name: "Fluffy", approximate_age: 1, description: "Puppy", adoptable: true, sex: :male)
    @george = @shelter2.pets.create!(image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2016/05/19091354/Weimaraner-puppy-outdoors-with-bright-blue-eyes.20190813165758508-1.jpg", name: "George", approximate_age: 1, description: "Puppy", adoptable: true, sex: :male)
    @penny = @shelter2.pets.create!(image: "https://images.theconversation.com/files/319652/original/file-20200310-61148-vllmgm.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=754&fit=clip", name: "Penny", approximate_age: 1, description: "Puppy", adoptable: true, sex: :male)
    @norm = @shelter3.pets.create!(image: "https://vetstreet.brightspotcdn.com/dims4/default/93290b5/2147483647/thumbnail/645x380/quality/90/?url=https%3A%2F%2Fvetstreet-brightspot.s3.amazonaws.com%2F00%2F107440c81d11e09b940050568d6ceb%2Ffile%2FAustralian-Cattle-Dog-2-AP-645km081611.jpg", name: "norm", approximate_age: 4, description: "Norm", adoptable: true, sex: :male)
    @charlie = @shelter3.pets.create!(image: "https://static.scientificamerican.com/blogs/cache/file/7A1AA7B6-1E54-4974-96488CF81302DC7C_source.jpg?w=590&h=800&B84E174E-0675-48A0-971D72A4376AC80F", name: "Charlie", approximate_age: 1, description: "Puppy", adoptable: true, sex: :male)
    @clay = @shelter4.pets.create!(image: "https://media.npr.org/assets/img/2020/03/27/dogs-coronavirus-7ddabfde75121f5020c307e134cb60dfa746fe1c-s800-c85.jpg", name: "Clay", approximate_age: 1, description: "Puppy", adoptable: true, sex: :male)
    @ruff = @shelter4.pets.create!(image: "https://www.humanesociety.org/sites/default/files/styles/400x400/public/2019/02/dog-451643.jpg?h=bf654dbc&itok=txM-HxF8", name: "Ruff", approximate_age: 1, description: "Puppy", adoptable: true, sex: :male)

    PetApplication.create!(application: @app1, pet: @penny)
    PetApplication.create!(application: @app1, pet: @norm)
    PetApplication.create!(application: @app2, pet: @buddy)
    PetApplication.create!(application: @app2, pet: @fluffy)
    PetApplication.create!(application: @app2, pet: @george)
    PetApplication.create!(application: @app3, pet: @buddy)
    PetApplication.create!(application: @app3, pet: @ruff)
    PetApplication.create!(application: @app3, pet: @charlie)
    PetApplication.create!(application: @app4, pet: @clay)
    PetApplication.create!(application: @app4, pet: @george)

    @app1.update(description: "Please", status: "Pending")
    @app2.update(description: "Please", status: "Pending")
    @app3.update(description: "Please", status: "Pending")
    @app4.update(description: "Please", status: "Pending")
  end

  it 'admin shelter show page has shelter attributes' do
    visit "/admin/shelters/#{@shelter.id}"

    expect(page).to have_content("Shelter:")
    expect(page).to have_content("Zoo")
    expect(page).to have_content("Address: 456 Main St Denver, CO, 80021")
  end

  it 'admin shelter show page has shelter statistics' do
    visit "/admin/shelters/#{@shelter.id}"

    expect(page).to have_content("Statistics:")
    expect(page).to have_content("Average Pet Age:")
    expect(page).to have_content("Adoptable Pets:")
    expect(page).to have_content("Adopted Pets:")
  end

  it 'admin shelter show page has action required if apps are still pending' do
    visit "/admin/shelters/#{@shelter.id}"

    expect(page).to have_content("Action Required!")
    expect(page).to have_content("Buddy")
    expect(page).to have_content("Fluffy")
    expect(page).to have_link("Application #{@app2.id}")
    expect(page).to have_link("Application #{@app3.id}")
  end
end
