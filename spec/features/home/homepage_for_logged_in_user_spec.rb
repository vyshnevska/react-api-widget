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

  describe 'as a logged in user i want to see' do
    specify 'a link to create a new post' do
      expect(current_path).to                 eql root_path
      expect(find_link('New Post')[:href]).to end_with(new_post_path)
    end
  end
end