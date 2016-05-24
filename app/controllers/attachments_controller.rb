class AttachmentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def download
    @attachment = Attachment.find(params[:id])
    send_file @attachment.content.path, type: @attachment.content_content_type
  end
end
