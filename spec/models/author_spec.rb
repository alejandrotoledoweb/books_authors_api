require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(100) }
    it { should allow_value('2000-01-01').for(:birthdate) }
  end

  describe 'associations' do
    it { should have_many(:books).dependent(:destroy) }
  end
end
