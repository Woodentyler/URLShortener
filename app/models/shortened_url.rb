class ShortenedUrl < ApplicationRecord
  validates :author_id, :short_url, :long_url, presence: true
  validates :long_url, uniqueness: true
  validate :no_spamming, :nonpremium_max

  belongs_to :submitter,
  foreign_key: :author_id,
  primary_key: :id,
  class_name: :User

  has_many :visits,
  foreign_key: :url_id,
  primary_key: :id,
  class_name: :Visit

  has_many :visitors,
  Proc.new { distinct },
  through: :visits,
  source: :user

  has_many :tags,
           primary_key: :id,
           foreign_key: :url_id,
           class_name: :Tagging

  has_many :tag_topics,
           through: :tags,
           source: :tag_topic

  def self.random_code
    res = "http://www.shorturl.com/" + SecureRandom::urlsafe_base64
    while ShortenedUrl.exists?(short_url: res)
      res = "http://www.shorturl.com/" + SecureRandom::urlsafe_base64
    end
    res
  end

  def self::create_shortened_url(user, long_url)
    url = ShortenedUrl.new(author_id: user.id, long_url: long_url)

    url.short_url = ShortenedUrl.random_code

    url if url.save
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.where("created_at > '#{10.minutes.ago}'")
  end

  def no_spamming
    all_urls = ShortenedUrl.where("author_id = '#{self.author_id}' AND created_at > '#{1.minute.ago}'")

    if all_urls.count > 5
      p "Error was hit"
      errors[:base] << 'Too many URLs within the last 1 minute'
    end
  end

  def nonpremium_max
    url_count = ShortenedUrl.where("author_id = '#{author_id}'")
    if url_count > 5 && !self.submitter.premium
      errors[:base] << 'Need premium account to add more URLs'
    end
  end
end
