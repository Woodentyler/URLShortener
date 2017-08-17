class TagTopic < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :taggings,
           primary_key: :id,
           foreign_key: :tag_topic_id,
           class_name: :Tagging

  has_many :urls,
           through: :taggings,
           source: :tagged_url


  def popular_links
    res_urls = self.urls.sort_by { |url| url.visits.count }.reverse
    res_urls.map { |url| [url, url.visits.count] }[0..4]
  end

end
