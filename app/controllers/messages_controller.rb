class MessagesController < ApplicationController
  load_and_authorize_resource except: [:new_private, :new_post, :select, :mark_as_read]
  before_action :set_user, except: [:destroy]
  before_action :set_companion, only: [:new_private, :dialog, :mark_as_read]
  before_action :authenticate_user!, except: [:new_private, :new_post, :select]

  def index
    @messages = @user.received_messages.order(created_at: :desc).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def dialog
    @message = Message.new
    @messages = @user.dialog(@companion).page(params[:page]).per(15)
  end

  def mark_as_read
    @user.received_messages.sent_by(@companion).where(status: 'new').update_all(status: 'read')
    respond_to :js
  end

  def new_private
    @message = Message.new(message_params)
    @message.save
    @messages = @user.dialog(@companion).page(params[:page]).per(15)
    if @message.valid?
      respond_to :js
    else
      render nothing: true
    end
  end

  def new_post
    @post = Message.new(message_params)
    @post.save
    @posts = Request.find(message_params[:request_id]).posts.order(updated_at: :desc).page(params[:page]).per(10)
    if @post.valid?
      respond_to :js
    else
      render nothing: true
    end
  end

  def select
    @messages = @user.send(params[:messages_type]).order(created_at: :desc).page(params[:page]).per(10)
    respond_to :js
  end

  def destroy
    @post = Message.find(params[:id])
    @posts = @post.request.posts.order(updated_at: :desc)
    @post.destroy
    respond_to :js
  end

  def remove_selected
    ids = params.select{ |key| key.include?('id') }.map{ |key, value| key.split('_')[1].to_i }
    remove_messages(@user.messages.where(id: ids))
    redirect_to messages_url
  end

  def clear
    remove_messages(@user.messages)
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

  def remove_messages(collection)
    collection.each do |message|
      if message.access?(:both)
        message.update(access: message.sender == @user ? 'receiver' : 'sender')
      else
        message.destroy
      end
    end
  end
end
