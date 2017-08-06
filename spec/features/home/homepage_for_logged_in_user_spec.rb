require 'spec_helper'

RSpec.describe 'homepage: user logged in' do
  let(:user) { create :user, :authorized, username: 'John Doe' }

  before { capybara_login_user(user) }

  describe 'as a logged in user i want to see in navigation bar', js: true do
    specify 'a nav links' do
      within '.navbar-nav' do
        expect(find('li.active').text).to  eql 'Posts'
        expect(page).to have_content 'Sign Out'
        expect(page).to have_content 'Account'
      end
    end

    specify 'a search element' do
      within 'nav' do
        expect(page).to have_css('.search-input')
      end
    end
  end

  describe 'as a logged in user i want to', js: true do
    specify 'create a new post' do
      expect(current_path).to                 eql root_path
      click_on 'New Post'

      capybara_fill_in_post_form
      expect(current_path).to eql post_path(Post.last)
    end
  end
end