class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:uikit ]
  def uikit
    @user = current_user
  end

  def sitemap
  end
end
