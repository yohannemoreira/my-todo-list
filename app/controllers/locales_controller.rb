class LocalesController < ApplicationController
  skip_before_action :require_authentication

  def update
    session[:locale] = params[:locale]
    redirect_back(fallback_location: root_path)
  end
end
