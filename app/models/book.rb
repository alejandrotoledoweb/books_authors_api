class Book < ApplicationRecord
  belongs_to :author

  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 255 }
  validates :published_year, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: Time.now.year }, allow_nil: true

  validates :author_id, presence: true
end
