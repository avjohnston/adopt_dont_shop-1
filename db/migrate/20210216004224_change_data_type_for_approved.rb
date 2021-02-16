class ChangeDataTypeForApproved < ActiveRecord::Migration[5.2]
  def self.up
    change_table :pet_applications do |t|
      t.change :approved, :string
    end
  end
  def self.down
    change_table :pet_applications do |t|
      t.change :approved, :boolean
    end
  end
end
