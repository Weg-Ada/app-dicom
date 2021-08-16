class SessionsController < ApplicationController

  def new
  end

  def create
    patient = Patient.find_by(login: params[:login])
    if patient and patient.authenticate(params[:password])
      session[:patient_id] = patient.id
      flash[:success] = "Logged in! Welcome to Archiving System."
      redirect_to home_url
    else
      flash[:warning] = "Login or password is incorrect!"
      redirect_to login_url
    end
  end

  def destroy
    session[:patient_id] = nil
    flash[:info] = "Logged out! Bye!"
    redirect_to login_url
  end
end