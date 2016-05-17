class MessagesController < ApplicationController
  before_action :set_user, only: [:new, :index, :select, :dialog]
  before_action :set_companion, only: [:new, :dialog]
  before_action :authenticate_user!, except: [:new, :select]
  load_and_authorize_resource except: [:new, :select]

  def index
    @messages = @user.received_messages.private_messages.order(created_at: :desc)
  end

  def dialog
    @message = Message.new
    @messages = @user.dialog(@companion)
    new_messages = @user.received_messages.sent_by(@companion).where(status: 'new')
    new_messages_count = new_messages.size
    new_messages.update_all(status: 'read')
    @new_messages_count = @new_messages_count - new_messages_count
  end

  def new
    @message = Message.new(message_params)
    if @message.save
      @messages = @user.dialog(@companion)
    end
    respond_to :js
  end

  def select
    @messages = @user.send(params[:messages_type]).private_messages.order(created_at: :desc)
    respond_to :js
  end


  private


  def set_user
    @user = current_user
  end

  def set_companion
    @companion = User.find(params[:user])
  end

  def message_params
    params.require(:message).permit(:body, :message_type, :sender_id, :receiver_id)
  end

end
