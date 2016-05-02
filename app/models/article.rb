class Article < ActiveRecord::Base
  acts_as_ordered_taggable
  belongs_to :user
  validates :name, presence: true, length: { maximum: 150 }
  validates_presence_of :body, :tag_list
  has_attached_file :photo, default_url: 'missing-photo.jpg'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def article_url
    Translit.convert(name.split('.')[0], :english).html_safe
  end
end
