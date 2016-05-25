class MessagesController < ApplicationController
  load_and_authorize_resource except: [:new_private, :new_post, :select]
  before_action :set_user, except: [:destroy, :remove_selected]
  before_action :set_companion, only: [:new_private, :dialog]
  before_action :authenticate_user!, except: [:new_private, :new_post, :select]

  def index
    @messages = @user.received_messages.private_messages.order(created_at: :desc).page(params[:page]).per(10)
  end

  def dialog
    @message = Message.new
    @messages = @user.dialog(@companion)
    @user.received_messages.sent_by(@companion).where(status: 'new').update_all(status: 'read')
  end

  def new_private
    @message = Message.new(message_params)
    @message.save
    @messages = @user.dialog(@companion)
    respond_to :js
  end

  def new_post
    @message = Message.new(message_params)
    @message.save
    @posts = Request.find(message_params[:request_id]).wall_posts.page(params[:page])
    respond_to :js
  end

  def select
    @messages = @user.send(params[:messages_type]).private_messages.order(created_at: :desc).page(params[:page]).per(10)
    respond_to :js
  end

  def destroy
    @post = Message.find(params[:id])
    @posts = @post.request.wall_posts
    @post.destroy
    respond_to :js
  end

  def remove_selected
    ids = params.select{ |key| key.include?('id') }.map{ |key, value| key.split('_')[1].to_i }
    Message.private_messages.where(id: ids).destroy_all
    redirect_to messages_url
  end

  def clear
    @user.received_messages.private_messages.destroy_all
    @user.sent_messages.private_messages.destroy_all
    redirect_to messages_url
  end


  private


  def set_user
    @user = current_user
  end

  def set_companion
    @companion = User.find(params[:user])
  end

  def message_params
    params.require(:message).permit(:body, :message_type, :sender_id, :receiver_id, :request_id,
                                      attachments_attributes: [:id, :content, :_destroy] )
  end
end
