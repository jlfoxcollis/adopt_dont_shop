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
    if @app.all_approved
      @app.update_to_approved
    elsif @app.not_all_approved
      @app.update_to_rejected
    end
  end
end
