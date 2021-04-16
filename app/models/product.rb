class Product < ApplicationRecord
  enum status: { draft: 0, published: 1, archived: 2 }

  scope :long_title, ->(length = 15) { where('LENGTH(title) > ?', length) }
  scope :short_body, ->(length = 5) { where('LENGTH(description) < ?', length) }
  scope :search, ->(arg) { where('title LIKE ? or description LIKE ?', "%#{arg}%", "%#{arg}%") }

  has_one_attached :cover_image
  has_many_attached :images
  has_many :product_categories
  has_many :categories, through: :product_categories
  validates :stock, :price, numericality: { greater_than_or_equal_to: 0 }

  before_save :clean_data
  def clean_data
    self.title = title.upcase.squish
    self.description = description.humanize
  end
end
