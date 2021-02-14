class AdminsController < ApplicationController
  def index
    @applications = Application.all
  end

  
end
