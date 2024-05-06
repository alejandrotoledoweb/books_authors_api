class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 100 }
  validates :birthdate, presence: true
end
