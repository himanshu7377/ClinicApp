module Doctors
  class DashboardController < ApplicationController
    layout 'application'
    before_action :authenticate_user!
    before_action :authorize_doctor!




    def switch_to_receptionist
      current_user.switch_to(:receptionist)
      redirect_to root_path, notice: "You are now switched to the receptionist role."
    rescue ArgumentError => e
      redirect_to root_path, alert: e.message
    end

    def index
      @patients = Patient.all  # Example query, adjust as per your needs
      @patients_counts = Patient.group_by_day(:created_at).count
      @patients_times = Patient.group_by_hour(:created_at).count
      @patients_days = Patient.group_by_day(:created_at)

    
       # Set cache headers to prevent caching
  response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
  response.headers["Pragma"] = "no-cache"
  response.headers["Expires"] = "0"
    end


    def show
      @patient = Patient.find(params[:id])

      flash[:notice] = "Data Refreshed"
    end

    private

    def authorize_doctor!
      unless current_user.doctor?
        redirect_to root_path, alert: "Access denied! You are not authorized as a doctor."
      end

    end
  end
end
