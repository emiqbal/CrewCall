class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  # def new
  #   @profile = Profile.new
  # end

  # def create
  #   @profile = Profile.new(profile_params)
  #   @profile.user = current_user
  #   if @profile.save
  #     redirect_to profile_path(@profile)
  #   else
  #     render :new
  #   end
  # end

  def edit
    @profile = Profile.where(user: current_user)
    @profile = Profile.new if @profile.nil?
  end

  def update
    @profile = Profile.where(user: current_user)
    save_status = false
    if @profile.nil?
      # profile doesn't exist and must be created
      @profile = Profile.new(profile_params)
      @profile.user = current_user
      save_status = @profile.save
    else
      # profile already exists, just update it
      save_status = @profile.update(profile_params)
    end
    if save_status
      redirect_to profile_path(@profile)
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:bio, :department, :company_name)
  end
end
