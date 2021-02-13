class AdminsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.find(@application.pets.pluck(:id))
  end
end
