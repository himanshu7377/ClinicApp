# app/models/patient.rb
class Patient < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "user_id",optional: true
    belongs_to :doctor , class_name: "Doctor", foreign_key: "doctor_id", optional: true

    # belongs_to :registerperson, class_name: 'User', foreign_key: 'registerperson_id', optional: true

    # def registerperson_user
    #   User.find_by(id: registerperson)
    # end
  end
  