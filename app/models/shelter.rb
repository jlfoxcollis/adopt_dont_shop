class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  validates_presence_of :name, :address, :city, :state, :zip
  scope :admin_shelter, -> {find_by_sql('SELECT  "shelters".* FROM "shelters" ORDER BY name DESC')}
  scope :pending_apps, -> {find_by_sql('SELECT  DISTINCT "shelters"."name", "shelters"."id" FROM "shelters" LEFT OUTER JOIN "pets" ON "pets"."shelter_id" = "shelters"."id" LEFT OUTER JOIN "application_pets" ON "application_pets"."pet_id" = "pets"."id" LEFT OUTER JOIN "applications" ON "applications"."id" = "application_pets"."application_id" WHERE "applications"."application_status" = 1')}
  # scope :pending_apps, -> {includes(pets: :applications).where(:applications => {:application_status => 1})}

  def avg_pet_age
    adoptable = pets.where('adoptable = ?', true)
    adoptable.average(:approximate_age)
  end

  def pending_pets
    pending_pets = pets.joins(:applications).where('applications.application_status = ?', 1).select('applications.application_status AS pet_app_status, applications.id AS app_id, pets.*')
  end
end
