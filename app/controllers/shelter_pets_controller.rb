class ShelterPetsController < ApplicationController
  
  def index
    @shelter = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.new(shelter_pets_params)
    if pet.save
      redirect_to "/shelters/#{shelter.id}/pets"
    end
  end

  private

  def shelter_pets_params
    params.permit(:name, :image, :description, :age, :sex)
  end

end
