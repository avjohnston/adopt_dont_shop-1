class Admin::ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.find(@application.pets.pluck(:id))
    @pet_applications = @application.pet_applications
  end

  def update
    if params[:approved]
      @application = Application.find(params[:id])
      @pet_application = @application.pet_applications.where(pet_id: params[:approved])
      @pet_application.update(approved: "true")
      @pet = Pet.find(params[:approved])
      @pet.update(adoptable: false)
    elsif params[:rejected]
      @application = Application.find(params[:id])
      @pet_application = @application.pet_applications.where(pet_id: params[:rejected])
      @pet_application.update(approved: "false")
    end

    redirect_to "/admin/applications/#{@application.id}"
  end
end
