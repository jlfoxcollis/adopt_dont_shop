class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def pet_count(arg)
    adoptable = pets.where('adoptable = ?', arg).count
  end
end
