class Product < ActiveRecord::Base
	has_many :line_items
	
	before_destroy :ensure_not_referenced_by_any_line_item

	attr_accessible :available, :description, :image_url, :price, :title
	validates_presence_of :title, :description, :price
	validates_numericality_of :price, numericality: {greater_than_or_equal_to: 0.05}
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: {
	with: %r{\.(gif|jpg|png)\Z}i,
	message: 'must be a URL for GIF, JPG or PNG image.'
	}
	
	private
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line Items present')
			return false
		end
	end
end
