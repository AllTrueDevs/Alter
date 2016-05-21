class AdminAbility
  include CanCan::Ability
  def initialize(user)
    # TODO need to move this ability into ability.rb then in rails_admin.rb remove ", AdminAbility"
    if user && user.with_privileges?
      can :access, :rails_admin
      can :dashboard
      can :manage, :all if user.role?(:admin)
      can :manage, Category if user.role?(:moderator)
    end
  end
end