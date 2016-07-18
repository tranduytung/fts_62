class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user
    when User
      can :read, :all
      can :manage, Question
      can [:create, :update], Exam
    when Admin
      can :manage, :all
    end
  end
end
