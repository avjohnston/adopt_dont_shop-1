class PetApplicationsController < ApplicationController

  def create
   @pet = Pet.find(params[:pet_id])
   @application = Application.find(params[:id])
   @pet_applications = PetApplication.create(pet: @pet, application: @application)
   redirect_to "/applications/#{@application.id}"
  end

end
