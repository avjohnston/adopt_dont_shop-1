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
    @pet_apps = @application.pet_applications
    if params[:approved]
      @pet_application = @application.pet_applications.where(pet_id: params[:approved])
      @pet_application.update(approved: "true")
      if @pet_apps.all? { |pet_app| pet_app.approved == "true" } == true
        @application.update(status: "Approved")
        @application.pets.each { |pet| pet.update(adoptable: false) }
      end
    else params[:rejected]
      @pet_application = @application.pet_applications.where(pet_id: params[:rejected])
      @pet_application.update(approved: "false")
      if @pet_apps.any? { |pet_app| pet_app.approved == "false"} == true && @pet_apps.any? { |pet_app| pet_app.approved == "none" } == false
        @application.update(status: "Rejected")
      end
    end
    redirect_to "/admin/applications/#{@application.id}"
  end
end
