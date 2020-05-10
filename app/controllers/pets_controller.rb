class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    pet.delete
    redirect_to "/pets"
  end

  def adoptable
    pet = Pet.find(params[:id])
    pet.status = false
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def pending
    pet = Pet.find(params[:id])
    pet.status = true
    pet.save
    redirect_to "/pets/#{pet.id}"
  end



  private

  def pet_params
    params.permit(:name, :image, :description, :sex, :age)
  end
end
