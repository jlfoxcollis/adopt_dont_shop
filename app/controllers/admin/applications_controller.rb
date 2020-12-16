class Admin::ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  def show
    @app = Application.find(params[:id])
    @pets = @app.pet_apps(params[:id])
    app_status
  end

  def app_status
    if @app.all_approved == true
      @pets.all.update({adoptable: false})
      @app.update!({application_status: 2})
    elsif @app.not_all_approved == true
      @app.application_pets.update({status: false})
      @app.update!({application_status: 3})
    end
  end
end
