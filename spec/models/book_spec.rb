require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    # it { should validate_presence_of(:title) }
    # it { should validate_uniqueness_of(:title).case_insensitive }
    it { should validate_length_of(:title).is_at_least(2).is_at_most(255) }
    it { should validate_numericality_of(:published_year).only_integer.is_greater_than(0).is_less_than_or_equal_to(Time.now.year).allow_nil }
    it { should validate_presence_of(:author_id) }
  end

  describe 'associations' do
    it { should belong_to(:author) }
  end
end
