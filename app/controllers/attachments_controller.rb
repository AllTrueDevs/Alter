class AttachmentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def download
    @attachment = Attachment.find(params[:id])
    data = open(@attachment.content.url)
    send_file data.read, type: @attachment.content_content_type
  end
end
