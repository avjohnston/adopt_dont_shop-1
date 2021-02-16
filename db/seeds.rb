# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

shelter = Shelter.create!(name: "Shelter", address: "456 Main St", city: "Denver", state: "CO", zip: "80021")
app1 = Application.create!(name: "Andrew", street: "123 Main St", city: "Denver", state: "CO", zipcode: "80021")
app2 = Application.create!(name: "Khoa", street: "321 Broadway St", city: "Denver", state: "CO", zipcode: "80021")

buddy = shelter.pets.create!(image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/20113314/Carolina-Dog-standing-outdoors.jpg", name: "Buddy", approximate_age: 4, description: "Doggy", adoptable: true, sex: :male)
fluffy = shelter.pets.create!(image: "https://ei.marketwatch.com/Multimedia/2020/04/09/Photos/ZQ/MW-IE203_corona_20200409232441_ZQ.jpg?uuid=d12f4334-7ada-11ea-b13a-9c8e992d421e", name: "Fluffy", approximate_age: 1, description: "Puppy", adoptable: true, sex: :male)
