class ApplicationPetsController < ApplicationController

  def create
    app_pet = ApplicationPet.new(privvy_params)

    app_pet.save
    redirect_to application_path(params[:application_id])
  end

  def update
    app_pet = ApplicationPet.find(params[:pet_app_id])
    app_pet.update!(privvy_params)
    redirect_to admin_application_path(params[:app_id])
  end


  private

  def privvy_params
    params.permit(:pet_id, :application_id, :status)
  end
end
