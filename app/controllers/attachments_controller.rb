class AttachmentsController < ApplicationController
  require 'open-uri'
  load_and_authorize_resource
  before_action :authenticate_user!

  def download
    @attachment = Attachment.find(params[:id])
    data = open(@attachment.content.url)
    send_data data.read, filename: @attachment.content_file_name, type: @attachment.content_content_type, disposition: :attachment
  end
end
