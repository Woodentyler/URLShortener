# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Visit.destroy_all
ShortenedUrl.destroy_all
Tagging.destroy_all
TagTopic.destroy_all

ActiveRecord::Base.transaction do

first_guy = User.new(email: 'some@email.com')
first_guy.save!
  url1 = ShortenedUrl.create_shortened_url(first_guy, 'amazon.com')

  url2 = ShortenedUrl.create_shortened_url(first_guy, 'somethingelse.com')

  url3 = ShortenedUrl.create_shortened_url(first_guy, 'Shouldnt return at all')

  url4 = ShortenedUrl.create_shortened_url(first_guy, 'somethingelse2.com')

  url5 = ShortenedUrl.create_shortened_url(first_guy, 'somethingelse3.com')

  url6 = ShortenedUrl.create_shortened_url(first_guy, 'somethingelse4.com')


second_guy = User.new(email: 'second@guy.com')
second_guy.save!
Visit.record_visit!(second_guy, url1)
Visit.record_visit!(second_guy, url1)
Visit.record_visit!(second_guy, url1)
Visit.record_visit!(second_guy, url1)
Visit.record_visit!(second_guy, url1)
Visit.record_visit!(second_guy, url1)
Visit.record_visit!(second_guy, url1)
Visit.record_visit!(second_guy, url1)
Visit.record_visit!(second_guy, url1)
Visit.record_visit!(first_guy, url2)
Visit.record_visit!(first_guy, url4)
Visit.record_visit!(first_guy, url5)
Visit.record_visit!(first_guy, url6)
Visit.record_visit!(first_guy, url6)
Visit.record_visit!(first_guy, url6)

news = TagTopic.new(name: 'News')
news.save!

tag = Tagging.new(tag_topic_id: news.id, url_id: url1.id)
tag.save!
tag1 = Tagging.new(tag_topic_id: news.id, url_id: url2.id)
tag1.save!
tag2 = Tagging.new(tag_topic_id: news.id, url_id: url3.id)
tag2.save!
tag3 = Tagging.new(tag_topic_id: news.id, url_id: url4.id)
tag3.save!
tag4 = Tagging.new(tag_topic_id: news.id, url_id: url5.id)
tag4.save!
tag5 = Tagging.new(tag_topic_id: news.id, url_id: url6.id)
tag5.save!

Tagging.new(tag_topic_id: news.id, url_id: url1.id)
Tagging.new(tag_topic_id: news.id, url_id: url1.id)
Tagging.new(tag_topic_id: news.id, url_id: url1.id)


end
