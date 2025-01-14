require 'rails_helper'

RSpec.describe '/merchants/:merchant_id/items/:id/edit' do
  before(:each) do
    test_data
  end

  describe 'I am taken to a page to edit this item' do
    it 'shows a form filled in with the existing item attribute information' do
      @item1.update(unit_price: 15000)
      visit(edit_merchant_item_path(@merchant, @item1))

      expect(page).to have_content("Little Esty Shop")
      expect(page).to have_content(@merchant.name)
      expect(page).to have_field('Name', with: @item1.name)
      expect(page).to have_field('Description', with: @item1.description)
      expect(page).to have_field('Unit Price', with: 15000)
      
      fill_in 'Name', with: 'Super Soaker'
      click_button("Submit")
      expect(current_path).to eq(merchant_item_path(@merchant, @item1))
      expect(page).to have_content('Super Soaker')
    end

    it 'dispalys an error message when the form is not completed' do
      @item1.update(unit_price: 15000)
      visit(edit_merchant_item_path(@merchant, @item1))

      expect(page).to have_content("Little Esty Shop")
      expect(page).to have_content(@merchant.name)
      expect(page).to have_field('Name', with: @item1.name)
      expect(page).to have_field('Description', with: @item1.description)
      expect(page).to have_field('Unit Price', with: 15000)
      
      fill_in 'Name', with: 'Super Soaker'
      fill_in 'Description', with: ''
      click_button("Submit")

      expect(page).to have_content("You messed up. Please try again")
    end
  end
end