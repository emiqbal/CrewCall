class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
<<<<<<< HEAD
     devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :is_producer, :photo])
=======
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :is_producer, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :is_producer, :photo])
>>>>>>> a19f2a1bdfbc7a6b6c46ada33d3f9e3c2f3db209
  end

end
