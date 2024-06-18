# app/controllers/patients_controller.rb
class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # before_action :authorize_receptionist, only: [:new, :create, :edit, :update, :destroy]

  def index
    @patients = Patient.all
    @patient_counts = current_user.patients.group_by_day(:created_at).count
  end


  def set_patient 
    @patient = Patient.find(params[:id])
  end
  def show
   
    @patient = current_user.patients.find(params[:id])
  rescue ActiveRecord::RecordNotFound
   
    redirect_to patients_path, alert: "Patient not found."
  end
  def new
    @patient = current_user.patients.build
  end

  def create
    @patient = current_user.patients.build(patient_params)
     puts "Params received: #{params.inspect}"
    # @patient.registerperson = current_user.name
    @patient.user = current_user
    if @patient.save
      redirect_to patients_path, notice: "Patient was successfully created."
    else
      logger.error("Error saving patient: #{@patient.errors}")
      render :new
    end
  end
  def edit
    @patient = current_user.patients.find(params[:id])
  end

  def update
    @patient = current_user.patients.find(params[:id])

    if @patient.update(patient_params)
      redirect_to @patient, notice: "Patient was successfully updated."
    else
      render :edit
    end
  end

  # def destroy
  #   @patient = current_user.patients.find(params[:id])
  #   @patient.destroy
  #   redirect_to patients_path, notice: "Patient was successfully destroyed."
  # end

  def destroy
    @patient.destroy
    redirect_to patients_url, notice: 'Patient was successfully destroyed.'
  end


  # def destroy
  #   @patient = Patient.find(params[:id])
  #   @patient.destroy
  #   redirect_to patients_path, notice: 'Patient was successfully deleted.'
  # end

  private

  def authorize_receptionist
    redirect_to root_path, alert: 'Access denied.' unless current_user&.receptionist?
  end

  def patient_params
    params.require(:patient).permit(:name, :age, :medical_history, ).merge(user_id: current_user.id)
  end
end
