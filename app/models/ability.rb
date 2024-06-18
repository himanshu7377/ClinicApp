class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role?(:receptionist)
      can :manage, Patient
    elsif user.has_role?(:doctor)
      can :read, Patient
    end
  end
end
