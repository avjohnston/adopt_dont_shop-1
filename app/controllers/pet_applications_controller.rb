class PetApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    binding.pry
    @application = Application.find(params[:id])
    @pets = Pet.where(id: PetApplication.where(application_id: Application.where(id: params[:id])))
  end

  def create
   @pet = Pet.find(params[:pet_id])
   @application = Application.find(params[:id])
   @pet_applications = PetApplication.create(pet: @pet, application: @application)
   if @pet_applications.save
     flash[:success] = "Application successfully saved!"
     redirect_to "/applications/#{@application.id}"
   else
     flash[:error] = "Application was not saved!"
     render :back
   end
 end

end
