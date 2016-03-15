class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action [ :destroy, :create, :update ], to: :cud

    can [ :actual_requests, :archived_requests ], User
    can :read, Request

    if user
      can [ :show, :statistic ], User
      cannot :read, Category
      can :create, Request

      can :destroy, Request do |request|
        request.user == user && request.actual? || user.with_privileges?
      end

      can :update, Request do |request|
        request.user == user
      end

      can :manage, Decision do |decision|
        decision.request.user == user
      end

      can :manage, Notification do |notification|
        notification.user == user
      end

      if user.with_privileges?
        can :manage, Category
        can :destroy, Request
      end

      case user.role
      when 'admin'
        can :manage, User
      when 'moderator'
        can [ :change_ban_status, :index ], User
      when 'banned'
        cannot :cud, Request
        cannot :cud, Decision
        cannot [ :update, :edit ], User

        cannot :show, User do |usr|
          usr != user
        end

        cannot [ :show, :index ], Request do |request|
          request.user != user
        end

        can :manage, Notification do |notification|
          notification.user == user
        end
      end
    end
  end
end
