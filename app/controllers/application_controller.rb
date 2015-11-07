class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_variables


  protected

  def set_variables
    if current_user
      gon.user = current_user.attributes.slice("encrypted_id")
    end
  end
end
