class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  after_initialize :default, unless: :persisted?

  def default
    self.status = "In Progress"
    self.description = "Write why you would make a good pet parent"
  end
end
