class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :verify_admin, except: [:index, :show, :edit]

  # GET /patients
  # GET /patients.json
  def index
    if current_user.is_admin
      @patients = Patient.all
	else
	  @patients = []
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    if current_user.is_admin
    end
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
    if current_user.is_admin
    end
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        flash[:success] = "Patient was successfully created."
        format.html { redirect_to @patient }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        flash[:info] = "Patient was successfully updated."
        format.html { redirect_to @patient }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      flash[:warning] = "Patient was successfully destroyed."
      format.html { redirect_to patients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :login, :password, :password_confirmation, :is_admin)
    end
end