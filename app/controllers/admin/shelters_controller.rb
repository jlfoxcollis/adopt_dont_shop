class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.admin_shelter
    @pending_shelters = Shelter.pending_apps
  end

  def show
    @shelter = Shelter.find(params[:id])
    if @shelter.pending_pets != []
      @pending_pets = @shelter.pending_pets
    end
  end
end
