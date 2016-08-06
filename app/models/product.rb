class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items

  validates_presence_of :title, :description, :url
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  before_destroy :ensure_not_referenced_by_any_line_item

  def self.latest
    Product.order(:updated_at).last
  end

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, "Line Items present in this product")
      return false
    end
  end
end
