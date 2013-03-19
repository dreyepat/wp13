class Product < ActiveRecord::Base

	attr_accessible :available, :description, :image_url, :price, :title
	validates_presence_of :title, :description, :price
	validates_numericality_of :price, numericality: {greater_than_or_equal_to: 0.05}
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: {
	with: %r{\.(gif|jpg|png)\Z}i,
	message: 'must be a URL for GIF, JPG or PNG image.'
	}
  
end
