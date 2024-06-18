class UsersController < ApplicationController
  before_action :authenticate_user!

  def switch_role
    role_name = params[:role]

    if current_user.update(role: role_name)
      case role_name
      when "doctor"
        redirect_to doctors_dashboard_index_path
      when "receptionist"
        redirect_to patients_path
      else
        flash[:error] = "Role not recognized"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:error] = "Failed to switch role: #{current_user.errors.full_messages.join(', ')}"
      redirect_back(fallback_location: root_path)
    end
  end
end
