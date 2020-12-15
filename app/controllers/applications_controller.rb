class ApplicationsController < ApplicationController
  def new
    @app = Application.new
  end

  def create
    @app = Application.new(application_params)
    if @app.save
      redirect_to application_path(@app.id)
    else
      # binding.pry
      flash.now[:notice] = @app.errors.full_messages
      render :new, action: @app
    end
  end

  def show
    @app = Application.find(params[:id])
    @pets = Pet.adoptable
    @chosen_ones = @app.pets
    if params[:search]
        @selected = Pet.search_pets(params[:search])
    end
    if params[:adopt] && params[:pet_id]
      pet = Pet.find(params[:pet_id])
      ApplicationPet.create!(pet: pet, application: @app)
    end
  end

  def update
    app = Application.find(params[:id])
    app.update!(update_params)
    redirect_to application_path(app.id)
  end

  private

  def application_params
    params.require(:application).permit(:name, :street, :city, :state, :zip_code, :description)
  end

  def update_params
    params.permit(:application_status)
  end
end
