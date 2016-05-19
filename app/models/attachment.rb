class Attachment < ActiveRecord::Base
  belongs_to :message

  {
      image: %w(image/jpg image/jpeg image/png image/gif),
      audio: %w(audio/mp3 audio/mpeg),
      doc: %w(application/pdf text/plain),
      video: %w(video/mp4 video/avi video/mpeg)
  }.each do |key, value|
    define_singleton_method("#{key}_types"){ value }
    define_singleton_method("#{key}?"){ |type| value.include?(type) }
  end

  def self.all_types
    [:image, :audio, :doc, :video].sum{ |type| Attachment.send("#{type}_types") }
  end

  has_attached_file :content
  validates_attachment_content_type :content, :content_type => Attachment.all_types,
                                    :size => { :in => 0..100.megabytes }


  scope :image_attachments, -> { where(content_content_type: Attachment.image_types) }

  def select_icon
    type = content_content_type
    case
    when Attachment.audio?(type) then 'music'
    when Attachment.video?(type) then 'facetime-video'
    when Attachment.doc?(type) then 'file'
    end
  end

  def form_name
    if content_file_name.length > 20
      format = content_file_name.split('.').last
      "#{content_file_name[0..(19 - format.length - 3)]}...#{format}"
    else
      content_file_name
    end


  end

end
