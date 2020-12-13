class AdminController < ApplicationController
  def index
    @shelters = Shelter.all.order('name ASC')
    @applications = Application.where('application_status <> ?', "In Progress")
  end
end
