class AddIndexToShortenedUrLs < ActiveRecord::Migration[5.1]
  def change
    add_index :shortened_urls, :long_url, unique: true
  end
end
