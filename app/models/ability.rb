class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user
    when User
      can :read, :all
    when Admin
      can :manage, :all
    end
  end
end
