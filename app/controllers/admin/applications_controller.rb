class Admin::ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.find(@application.pets.pluck(:id))
    if params[:approved]
      @pet_application = @application.pet_applications.where(pet_id: params[:pet_id])
    end
  end

  def update
    @application = Application.find(params[:id])
    @pet_application = @application.pet_applications.where(pet_id: params[:pet_id])
    @pet = Pet.find(params[:approved])
    @pet.update(adoptable: false)
    @pet_application.update(approved: true)
    redirect_to "admin/applications/#{@application.id}/?accepted=$#{params[:pet_id]}"
  end
end
