class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @profiles = Profile.where(user: User.where(is_producer: false))
  end

  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
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
    if current_user.profile.nil?
      @notifications = current_user.notifications.unread
      @profile = Profile.new
    else
      @profile = Profile.find_by(user: current_user)
    end
  end

  def update
    if current_user.profile.nil?
      # profile doesn't exist and must be created
      @profile = Profile.new(profile_params)
      @profile.user = current_user
      save_status
    else
      @profile = Profile.find_by(user: current_user)
      # profile already exists, just update it
      @profile.update(profile_params)
      save_status
    end
  end

  private

  def save_status
    if @profile.save
      redirect_to profile_path(@profile)
    else
      render :edit
    end
  end

  def profile_params
    params.require(:profile).permit(:bio, :department, :company_name, :last_name, :first_name, :photo)
  end
end
