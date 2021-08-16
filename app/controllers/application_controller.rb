class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    return unless session[:patient_id]
    @current_user ||= Patient.find(session[:patient_id])
  end

  def verify_admin
    redirect_to root_path unless current_user.is_admin
  end

  def autenticate_user
    redirect_to root_path unless current_user
  end
end