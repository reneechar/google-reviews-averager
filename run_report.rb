require 'watir'
require 'selenium-webdriver'
require 'pry'

REVIEWER_NAME = ENV['REVIEWER_NAME']
REVIEWER_COMMENT = ENV['REVIEWER_COMMENT'] ? ENV['REVIEWER_COMMENT'] : ''
REVIEWER_COMMENT_FRAG = REVIEWER_COMMENT.scan(/.{1,150}/).first
URL = ENV['URL']

b = Watir::Browser.new(:chrome)

b.goto URL

Watir::Wait.until { b.button(id: "searchbox-searchbutton").present? }
b.button(id: "searchbox-searchbutton").click

sleep 3
b.div(class: "section-hero-header-description").click
b.send_keys(:alt,:arrow_down)
b.send_keys(:alt,:arrow_down)
b.send_keys(:alt,:arrow_down)

Watir::Wait.until { b.button(text: "See all reviews").present? }
b.button(text: "See all reviews").click

Watir::Wait.until { b.div(class: "gm2-caption", text: /review/).present? }
total_reviews = b.div(class: "gm2-caption", text: /review/).text.split(" ").first.to_i
puts b.div(class: "gm2-caption", text: /review/).text

Watir::Wait.until { b.div(class: "goog-inline-block").present? }
b.div(class: "goog-inline-block").click
Watir::Wait.until { b.div(text: "Newest").present? }
b.div(text: "Newest").click

while (b.divs(class: "section-review").count < total_reviews)
  b.send_keys(:alt,:arrow_down)
end

found_last_review = false
reviews = []

b.divs(class: "section-review-line").each do |r|
  name = r.text.split("\n").first
  if found_last_review
    star_count = 0
    r.children.first.children[2].children.first.children[1].children.each do |c|
      if c.classes.include? 'section-review-star-active'
        star_count += 1
      end
    end
    puts name
    puts star_count
    reviews << star_count
  end

  unless found_last_review
    if name == REVIEWER_NAME
      comment = r.children.first.children[2].children[1].text
      if ((comment.nil? && REVIEWER_COMMENT_FRAG.nil?) ||
         (!!comment.match(/#{REVIEWER_COMMENT_FRAG}/)))
        puts 'found match'
        found_last_review = true
      end
    end
  end
end

review_average = reviews.inject{ |sum, el| sum + el }.to_f / reviews.size

puts "total reviews before commenter: #{reviews.length}"
puts "average reviews before commenter: #{review_average}"
