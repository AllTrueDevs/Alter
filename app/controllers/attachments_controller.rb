class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def download
    @attachment = Attachment.find(params[:id])
    send_file @attachment.content.path, :type => @attachment.content_content_type
  end
end
