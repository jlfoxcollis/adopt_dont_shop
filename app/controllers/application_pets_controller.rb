class ApplicationPetsController < ApplicationController

  def create
    app_pet = ApplicationPet.new(privvy_params)
    @app = Application.find(params[:application_id])
    @pets = Pet.adoptable
    @chosen_ones = @app.pets
    if app_pet.save
      redirect_to application_path(params[:application_id])
    else
      flash.now[:notice] = "Pet already exists on Application"
      redirect_to application_path(params[:application_id])
    end
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
