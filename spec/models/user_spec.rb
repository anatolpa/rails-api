require "rails_helper"

RSpec.describe User, type: :model do
  subject { build :user }
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of :email }
    it { is_expected.to validate_presence_of :email   }
  end

  describe 'associations' do
    it { is_expected.to have_many :sessions }
  end
end