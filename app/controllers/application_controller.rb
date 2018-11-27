class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :authenticate_user!

  # before_action :set_time

  # def set_time
  #   @time = Time.now
  # end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
  protected :layout_by_resource
end
