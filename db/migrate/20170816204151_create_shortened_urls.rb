class CreateShortenedUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :shortened_urls do |t|
      t.integer :author_id, null: false, unique: true
      t.string :short_url, null: false
      t.string :long_url, null: false, unique: true

      t.timestamps
    end
  end
end
