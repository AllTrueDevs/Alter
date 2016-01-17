class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :edit, :destroy, :create, :to => :modify
    alias_action :edit, :update, :destroy, :to => :author_action
    alias_action :show, :destroy, :to => :user_action
    alias_action :ban, :unban, :to => :ban_users
    alias_action :accept, :deny, :to => :decision_action
    alias_action :actual_requests, :archived_requests, :to => :ajax_request
    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      cannot :read, Category
      can :create, Request
      can :create, Decision
      can :decision_action, Decision do |decision|
        decision.request.user == user
      end
      can :ajax_request, User
      if user.role == 'moderator'
        can :destroy, Request
        can :manage, Category
        can :ban_users, User
      elsif user.role == 'author'
        cannot :index, User
        can :author_action, Request do |request|
          request.user == user
        end
      elsif user.role == 'banned'
        cannot :index, User
        cannot :create, Decision
        cannot :modify, :all
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
