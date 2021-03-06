class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
    @pending_apps = Shelter.pending_apps
  end

  def show
    @shelter = Shelter.find_by_sql("SELECT * FROM shelters WHERE id = #{params[:id]}").first
    @action_pets = @shelter.action_pets
  end
end
