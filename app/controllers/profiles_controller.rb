class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
  end

  def create
  end

  def edit
  end

  def update
  end

  private

  def profile_params
    params.require(:profile).permit(:title, :description, :photo, :start_date, :end_date)
  end
end
