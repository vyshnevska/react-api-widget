require 'spec_helper'

RSpec.describe Post, type: :model do

  describe 'associations' do
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
    it { should have_many(:comments).with_foreign_key('parent_post_id') }
    it { should have_many(:replies).through(:comments) }
    it { should have_many(:subscriptions).through(:channel) }
    it { should have_one(:channel).through(:author) }

    it { should belong_to(:parent_post) }
    it { should belong_to(:author).with_foreign_key('author_id') }
  end

  describe 'scopes' do
    specify('published') {
      expect(Post.published.to_sql)
        .to eq "SELECT \"posts\".* FROM \"posts\" WHERE \"posts\".\"published\" = 't'" }

    specify('original') {
      expect(Post.original.to_sql)
        .to eq "SELECT \"posts\".* FROM \"posts\" WHERE \"posts\".\"parent_post_id\" IS NULL" }

    specify('recent') {
      expect(Post.recent.to_sql).to eq  "SELECT \"posts\".* FROM \"posts\" ORDER BY updated_at desc" }
  end

  describe 'serialization, #to_h' do
    let(:post) { build_stubbed :post, :full }

    specify 'builds all hash keys' do
      expect(post.to_h.keys).to match_array %i(slug body published title publishedAt author channel topImageUrl)
    end

    specify 'builds author k,v' do
      expect(post.to_h[:author]).to eq({id: post.author_id, name: post.author.name, avatar_url: nil })
    end

    specify 'builds channel k,v' do
      expect(post.to_h[:channel]).to eq nil
    end
  end

  describe '#subscription_hash' do
    let(:post) { build :post }

    specify 'for no logged in user' do
      expect(post.subscription_hash).to eq({ isSubscribed: false,  currentUser: nil })
    end

    context 'for a logged in user' do
      let(:user) { build_stubbed :user }
      specify {
        expect(post.subscription_hash(user)).to eq({ isSubscribed: false,  currentUser: { id: user.id } })
      }
    end

    context 'for a subscribed user' do
      let(:post) { create :post, :full }
      let(:user) { create :user }

      specify do
        post.channel.subscriptions << build(:subscription, user: user)
        expect(post.subscription_hash(user)).to eq({ isSubscribed: true,  currentUser: { id: user.id } })
      end
    end
  end
end