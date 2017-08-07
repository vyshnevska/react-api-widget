require 'spec_helper'

RSpec.describe 'homepage: user logged out' do

  describe 'as a logged out user i want to see in navigation bar' do
    before { visit root_path }

    specify 'a brand element' do
      within 'nav' do
        expect(find('.navbar-brand').text).to eql 'Home'
      end
    end

    specify 'a nav links' do
      within '.navbar-nav' do
        expect(find('li.active').text).to  eql 'Posts'
        expect(page).to have_content 'Sign Up'
        expect(page).to have_content 'Sign In'
      end
    end

    specify 'a search element' do
      within 'nav' do
        expect(page).to have_css('.search-input')
      end
    end
  end

  describe 'as a logged out user i want to see posts', js: true  do
    let!(:post)  { create :post, title: 'A Tech post' }

    specify 'rendered as a react component' do
      visit root_path
      expect(page).to have_css("div[data-react-class='Posts']")
      post_json = { posts: [
                              PostSerializer.new(post).to_h
                                .merge(isSubscribed: false, currentUser: nil)
                            ]
                  }.to_json
      expect(find(("div[data-react-class='Posts']"))['data-react-props']).to eql post_json
    end

    specify 'as a tile' do
      visit root_path
      within '#posts_component' do
        within '.post' do
          expect(page).to have_content 'A Tech post'
          expect(find_link(post.title)[:href]).to   end_with(post_path(post))
          expect(find('.published-date').text).to   eql "a second ago"
        end
      end
    end
  end
end