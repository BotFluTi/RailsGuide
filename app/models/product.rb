class Product < ApplicationRecord
  has_one_attached :featured_image
  validates :name, presence: true
  belongs_to :brand
end
