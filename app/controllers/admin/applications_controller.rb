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
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pet_apps = @application.pet_applications
    if params[:approved]
      @pet_application = @application.pet_applications.where(pet_id: params[:approved])
      @pet_application.update(approved: "true")
      all_approved
      rejected
    else params[:rejected]
      @pet_application = @application.pet_applications.where(pet_id: params[:rejected])
      @pet_application.update(approved: "false")
      rejected
    end
    redirect_to "/admin/applications/#{@application.id}"
  end

  def all_approved
    if @pet_apps.all? { |pet_app| pet_app.approved == "true" }
      @application.update(status: "Approved")
      @application.pets.each { |pet| pet.update(adoptable: false) }
    end
  end

  def rejected
    if @pet_apps.any? { |pet_app| pet_app.approved == "false" } && @pet_apps.none? { |pet_app| pet_app.approved == "none" }
      @application.update(status: "Rejected")
    end
  end
end
