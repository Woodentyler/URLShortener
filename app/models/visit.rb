class Visit < ApplicationRecord
  validates :user_id, :url_id, presence: true

  def self.record_visit!(user, shortened_url)
     v = Visit.new(user_id: user.id, url_id: shortened_url.id)
     v if v.save!
  end

  belongs_to :user,
             foreign_key: :user_id,
             primary_key: :id,
             class_name: :User

  belongs_to :shortened_url,
             foreign_key: :url_id,
             primary_key: :id,
             class_name: :ShortenedUrl

end
