# app/models/user.rb

class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations for patients managed by receptionist and assigned to doctors
  has_many :patients, dependent: :destroy, foreign_key: "user_id"
  has_many :assigned_patients, class_name: "Patient", foreign_key: "doctor_id", dependent: :destroy


  enum role: {  receptionist: 0, doctor: 1 }
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :receptionist
  end

    # Define roles using Rolify
    after_create :assign_default_role

    def assign_default_role
      add_role(:receptionist) if roles.blank?
    end

  # Switch roles
  def switch_to(role_name)
    role_name = role_name.to_s.downcase
    if role_name == "doctor"
      update(role: "doctor")
    elsif role_name == "receptionist"
      update(role: "receptionist")
    else
    
      raise ArgumentError, "Invalid role: #{role_name}"
    end
  end
  

  # # Validations
  # validates :name, presence: true, length: { maximum: 50 }
  # validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  # validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  # validates :password_confirmation, presence: true

  

  def available_role?(role_name)
    Role.where(name: role_name).exists?
  end

  def after_role_switch_path(role)
    case role
    when 'Doctor'
      doctors_dashboard_index_path
    when 'Receptionist'
      patients_path
    else
      root_path
    end
  end


  def doctor?
    role == 'doctor'
  end

  def receptionist?
    role == 'receptionist'
  end
end
