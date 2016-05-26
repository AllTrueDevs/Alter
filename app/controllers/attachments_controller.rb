class AttachmentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def download
    @attachment = Attachment.find(params[:id])
    data = open(@attachment.content.url)
    send_file "http://alter-assets.s3.amazonaws.com/#{@attachment.content.path}", filename: @attachment.content_file_name, type: @attachment.content_content_type, disposition: :attachment
    send_data data.read, filename: @attachment.content_file_name, type: @attachment.content_content_type, disposition: 'attachment', stream: 'true', buffer_size: '4096'
  end
end
