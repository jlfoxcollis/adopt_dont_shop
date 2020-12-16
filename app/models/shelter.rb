class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :applications, through: :pets
  validates_presence_of :name, :address, :city, :state, :zip
  scope :admin_shelter, -> {find_by_sql('SELECT  "shelters".* FROM "shelters" ORDER BY name DESC')}
  scope :search, -> (arg) {find_by_sql("SELECT * FROM shelters WHERE id = #{arg}")}
  scope :pending_apps, -> {includes(pets: :applications).where(:applications => {:application_status => 1})}

  def avg_pet_age
    adoptable = pets.where('adoptable = ?', true)
    adoptable.average(:approximate_age)
  end

  def pending_pets
    pending_pets = pets.joins(:applications).where('applications.application_status = ?', 1).select('applications.application_status AS pet_app_status, applications.id AS app_id, pets.*')
  end
end
