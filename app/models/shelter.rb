class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  validates_presence_of :name, :address, :city, :state, :zip
  scope :admin_shelter, -> {order('name DESC')}
  scope :pending_apps, -> {includes(pets: :applications).where(:applications => {:application_status => "Pending"})}

  def avg_pet_age
    adoptable = pets.where('adoptable = ?', true)
    adoptable.average(:approximate_age)
  end

  def pending_pets
    pending_pets = pets.joins(:applications).where('applications.application_status = ?', "Pending").select('applications.application_status AS pet_app_status, applications.id AS app_id, pets.*')
  end
end
