require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end
end

context 'restaurants have been added' do
  before do
    Restaurant.create(name: 'Cat\'s pyjamas')
  end

  scenario 'display restaurants' do
    visit '/restaurants'
    expect(page).to have_content('Cat\'s pyjamas')
    expect(page).not_to have_content('No restaurants yet')
  end
end

context 'creating restaurants' do
  scenario 'prompts user to fill out a form, then displays the new restaurant' do
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'Cat\'s Pyjamas'
    click_button 'Create Restaurant'
    expect(page).to have_content 'Cat\'s Pyjamas'
    expect(current_path).to eq '/restaurants'
  end
end
