class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  after_initialize :default, unless: :persisted?

  def default
    self.approved = false
  end
end
