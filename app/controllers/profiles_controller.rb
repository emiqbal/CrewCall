class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
<<<<<<< HEAD

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
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to profile_path(@profile)
    else
      render :new
    end
  end
  

  def edit
    @profile = Profile.where(user: current_user)
    @profile = Profile.new if @profile.nil?
  end
  
  def update

    @profile = Profile.where(user: current_user)
=======
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
    @profile = Profile.find_by(user: current_user)
    @profile = Profile.new if @profile.nil?
  end

  def update
    @profile = Profile.find_by(user: current_user)
>>>>>>> a19f2a1bdfbc7a6b6c46ada33d3f9e3c2f3db209
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
<<<<<<< HEAD
  
  def profile_params
    params.require(:profile).permit(:bio, :department, :company_name, :photo)
  end
end
=======

  def profile_params
    params.require(:profile).permit(:bio, :department, :company_name)
  end
end
>>>>>>> a19f2a1bdfbc7a6b6c46ada33d3f9e3c2f3db209
