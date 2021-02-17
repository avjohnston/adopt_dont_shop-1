class Shelter < ApplicationRecord
  has_many :pets, :dependent => :destroy

  def self.pending_apps
    joins(pets: [{pet_applications: :application}]).where(applications: {status: "Pending"}).order("name").distinct
  end

  def average_pet_age
    pets.average(:approximate_age)
  end

  def adoptable_pets
    pets.where(adoptable: true).size
  end

  def adopted_pets
    pets.where(adoptable: false).size
  end

  def action_pets
    # pets.find(PetApplication.where(approved: "none").pluck(:pet_id))
    pets.action_pets.where(shelter_id: self.id).distinct
  end
end
