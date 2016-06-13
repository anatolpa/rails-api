require 'rails_helper'

RSpec.describe Task, type: :model do
  subject(:task) { build :task }
  describe 'validations' do
    it { is_expected.to validate_presence_of :operation }
    it { is_expected.to validate_presence_of :status }
    it do
      is_expected.to validate_inclusion_of(:status).
          in_array(['new', 'process', 'finished'])
    end
  end

  describe 'associations' do
    it { is_expected.to have_one :user }
    it { is_expected.to have_one :image }
    it { is_expected.to have_one :result }
  end

end
