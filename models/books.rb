class Books < ActiveRecord::Base
	validates :book_id, presence: true
	validates :title, presence: true
	validates :author, presence: true
	validates :image_url, presence: true
end
