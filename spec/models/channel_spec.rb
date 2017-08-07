require 'spec_helper'

RSpec.describe Channel, type: :model do

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe 'associations' do
    it { should have_many(:messages) }
    it { should have_many(:subscriptions) }
    it { should have_many(:subscribers).through(:subscriptions) }

    it { should belong_to(:user) }
  end

  describe 'scopes' do
    specify('active') {
      expect(Channel.active.to_sql)
        .to eq "SELECT \"channels\".* FROM \"channels\" WHERE \"channels\".\"active\" = 't'" }

    specify('by_popularity') {
      expect(Channel.by_popularity.to_sql)
        .to eq  "SELECT \"channels\".* FROM \"channels\" ORDER BY subscriptions_count desc" }
  end

  describe 'serialization, #to_h' do
    let(:channel) { build_stubbed :channel, :full }

    specify do
      expect(channel.to_h).to eq( { id: channel.id,
                                    name: channel.name,
                                    image_url: channel.image.url(:thumb),
                                    active: true
                                  })
    end
  end
end