class Application < ApplicationRecord
  has_many :pet_applications, :dependent => :destroy
  has_many :pets, through: :pet_applications
  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :street, presence: true
  validates :zipcode, presence: true

  after_initialize :default, unless: :persisted?

  def default
    self.status = "In Progress"
    self.description = "Write why you would make a good pet parent"
  end
end
