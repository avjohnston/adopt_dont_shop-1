class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    if params[:description]
      @application = Application.find(params[:id])
      @application.update(status: "Pending", description: params[:description])
      @application.save
    elsif params[:pet_name]
      @pets = Pet.name_search(params[:pet_name])
      @application = Application.find(params[:id])
    elsif params[:pet_id]
      @pet = Pet.find(params[:pet_id])
      @application = Application.find(params[:id])
      @pet_application = PetApplication.create(pet: @pet, application: @application)
      redirect_to "/applications/#{params[:id]}"
    else
      @application = Application.find(params[:id])
    end
  end

  def admin_show
    @application = Application.find(params[:id])
    @pets = Pet.find(@application.pets.pluck(:id))
  end

  def new

  end

  def create
    application = Application.new({
      name: params[:name],
      street: params[:street],
      city: params[:city],
      state: params[:state],
      zipcode: params[:zipcode],
      status: "In Progress"
      })
    application.save
    redirect_to "/applications/#{application.id}"
  end
end
