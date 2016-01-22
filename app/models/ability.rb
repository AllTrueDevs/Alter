class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Request
    if !user.nil?
      alias_action :edit, :destroy, :create, :update, :to => :modify
      alias_action :edit, :update, :destroy, :to => :author_action
      alias_action :show, :destroy, :to => :user_action
      alias_action :accept, :deny, :partly, :read, :create, :to => :decision_action
      if user.role == 'admin'
        can :manage, :all
        cannot :edit, Request do |request|
          request.user != user
        end
      else
        can :statistic, User
        can :create, Request
        cannot :read, Category
        can :modify, Request do |request|
          request.user == user
        end
        can :decision_action, Decision do |decision|
          decision.request.user == user
        end
        can [:read, :destroy], Notification do |notification|
          notification.user == user
        end
        if user.role == 'moderator'
          can :destroy, Request
          can :index, User
          can :manage, Category
          can :change_ban_status, User
        elsif user.role == 'author'
          can :author_action, Request do |request|
            request.user == user
          end
        elsif user.role == 'banned'
          cannot :modify, :all
        end
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
