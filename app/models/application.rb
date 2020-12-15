class Application < ApplicationRecord
  validates :name, :city, :description, presence: true
  validates :state, length: {maximum: 2}, presence: true
  validates :zip_code, numericality: { only_integer: true }, presence: true
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  def all_approved
    application_pets.where('status = ?', true).count == application_pets.count
  end

  def not_all_approved
    application_pets.where('status = ?', false).count >= 1 &&
    (application_pets.where('status = :t OR status = :f', t: true, f: false).count == application_pets.count)
  end

  def pet_apps(app_id)
    @pets = Pet.select('application_pets.id AS pet_app_id, pets.*, application_pets.status').joins(:application_pets).where('application_pets.application_id = ?', app_id)
  end
end
