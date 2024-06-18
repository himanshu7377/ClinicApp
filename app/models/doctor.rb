# app/models/doctor.rb
class Doctor < ApplicationRecord
    belongs_to :user
    validates :name, presence: true
    validates :specialization, presence: true
  end
  