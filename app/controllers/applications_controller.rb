class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def new
    @application = Application.new
  end

  def show
    if params[:pet_name]
      @pets = Pet.name_search(params[:pet_name])
      @application = Application.find(params[:id])
    else
      @application = Application.find(params[:id])
    end
  end

  def create
    @application = Application.create(applications_params)
    if @application.save
      flash[:success] = "Your Application Has Been Saved!"
      redirect_to "/applications/#{@application.id}"
    else
      flash[:error] = "Your Application Wasn't Saved!"
      render :new
    end
  end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    if params[:description]
      @application.update_attributes(description: params[:description], status: "Pending")
    else
      @application.update(applications_params)
    end
    redirect_to "/applications/#{@application.id}"
  end

  def destroy
    Application.destroy(params[:id])
    redirect_to '/applications'
  end

  private
  def applications_params
    params.permit(:name, :street, :city, :state, :zipcode, :description, :status)
  end

end
