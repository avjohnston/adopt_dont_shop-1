class PetApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    binding.pry
    @application = Application.find(params[:id])
    @pets = Pet.where(id: PetApplication.where(application_id: Application.where(id: params[:id])))
  end

end
