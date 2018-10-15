# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  let!(:link) { FactoryBot.create(:link) }
  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:short_url) }
    it { should validate_uniqueness_of(:url) }
    it { should validate_uniqueness_of(:short_url).case_insensitive }
    it { should allow_value('abc123').for(:short_url) }
    it { should_not allow_value('!bc123').for(:short_url) }
    it { should_not allow_value('abc1234').for(:short_url) }
    it { should allow_value('http://www.blacktangent.com').for(:url) }
    it { should_not allow_value('blacktangent.com').for(:url) }
  end
end
