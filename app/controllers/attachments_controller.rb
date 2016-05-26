class AttachmentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def download
    @attachment = Attachment.find(params[:id])
    send_file "http://alter-assets.s3.amazonaws.com#{@attachment.content.path}", filename: @attachment.content_file_name, type: @attachment.content_content_type, disposition: :attachment
  end
end
