class AdminController < ApplicationController
  def index
    @shelters = Shelter.all.order('name ASC')
    @applications = Application.where('application_status <> ?', 0)
    session[:secret] = "This time for real, though."
  end
end
