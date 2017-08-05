require 'spec_helper'

RSpec.describe 'homepage' do

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

  # describe 'as a logged out user i want to see posts', js: true  do
  #   let!(:post)  { create :post }
  #   let!(:post2) { create :post, published: false }

  #   specify 'only published' do

  #     visit root_path
  #   end
  # end
end