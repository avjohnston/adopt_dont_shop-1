class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
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
