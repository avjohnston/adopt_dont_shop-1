class ApplicationsController < ApplicationController

  def new
    @application = Application.new
  end

  def show
    if params[:pet_name]
      @pets = Pet.name_search(params[:pet_name])
      @application = Application.find(params[:id])
      @pet_applications = @application.pet_applications
    else
      @application = Application.find(params[:id])
      @pet_applications = @application.pet_applications
    end
  end

  def create
    @application = Application.create(applications_params)
    if @application.save
      flash[:success] = "Your Application Has Been Saved!"
      redirect_to "/applications/#{@application.id}"
    else
      flash[:error] = "Your Application Wasn't Saved! Please Fill Out All Fields."
      render :new
    end
  end

  def update
    @application = Application.find(params[:id])
    if params[:description]
      @application.update_attributes(description: params[:description], status: "Pending")
    end
    redirect_to "/applications/#{@application.id}"
  end

  # def destroy
  #   Application.destroy(params[:id])
  #   redirect_to '/applications'
  # end
  # def index
  #   @applications = Application.all
  # end
  # def edit
  #   @application = Application.find(params[:id])
  # end

  private
  def applications_params
    params.permit(:name, :street, :city, :state, :zipcode, :description, :status)
  end

end
