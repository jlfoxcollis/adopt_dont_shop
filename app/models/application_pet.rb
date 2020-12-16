class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  validates_uniqueness_of [:pet, :application], :scope => [:pet_id, :application_id]
end
