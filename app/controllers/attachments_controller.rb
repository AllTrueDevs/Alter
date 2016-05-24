class AttachmentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def download
    @attachment = Attachment.find(params[:id])
    data = open(@attachment.content.url)
    send_data data.read, filename: @attachment.content_file_name, type: @attachment.content_content_type, disposition: 'inline', stream: 'true', buffer_size: '4096'
  end
end
