class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action [:destroy, :create, :update], to: :cud
    alias_action [:upvote, :downvote], to: :vote

    can [:select_requests], User
    can :read, Request
    can :read, Article
    can(:download, Attachment){ |attachment| attachment.message.message_type.to_sym == :post }

    if user
      can [:show, :statistic, :activity], User
      can [:detach_social_link, :change_password], User do |usr|
        user == usr
      end

      can [:vote, :activity, :wall], Request
      can :vote, User do |usr|
        user != usr
      end

      can [:index, :dialog, :clear, :remove_selected], Message
      can :new_private, Message
      can [:new_post, :destroy], Message do |message|
        (message.request.user.id == user.id && !message.request.status?(:declined)) || user.with_privileges?
      end
      can :download, Attachment do |attachment|
        ((attachment.message.sender == user || attachment.message.receiver == user) && attachment.message.message_type.to_sym == :private_message)
      end

      cannot :read, Category
      can :create, Request

      can :destroy, Request do |request|
        request.user == user && request.status?(:actual) || user.with_privileges?
      end

      can :update, Request do |request|
        (request.user == user && !request.status?(:unchecked))
      end

      can :manage, Decision do |decision|
        decision.request.user == user
      end

      can :manage, Notification do |notification|
        notification.user == user
      end

      if user.with_privileges?
        can :manage, Category
        can [:unchecked, :destroy], Request
        can [:check, :decline], Request do |request|
          user.settlement.blank? || request.user.settlement.blank? || user.region == request.user.region
        end
      end

      case user.role
      when 'admin'
        can :manage, User
        can :manage, Article
      when 'moderator'
        can [:change_ban_status, :index, :search], User
      when 'newsmaker'
         can :manage, Article
      when 'banned'
        cannot :cud, Request
        cannot :cud, Decision
        cannot [:new_post, :new_private, :destroy], Message
        cannot [:update, :edit], User
        cannot :vote, Request
        cannot :vote, User

        cannot :show, User do |usr|
          usr != user
        end

        cannot [:show, :index], Request do |request|
          request.user != user
        end

        can :manage, Notification do |notification|
          notification.user == user
        end
      end
    end
  end
end
