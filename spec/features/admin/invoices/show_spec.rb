require 'rails_helper'

RSpec.describe 'Invoice Index' do
  describe 'when I visit the admin invoice index' do
    it 'US33 I see a list of all invoice ids' do
      test_data
      visit admin_invoice_path(@invoice1)

      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.customer.full_name)
    end

    it 'US34 I see all of the items on the invoice with their data' do
      test_data
      visit admin_invoice_path(@invoice1)

      expect(page).to have_content(@inv_itm1.item.name)
      expect(page).to have_content(@inv_itm1.quantity)
      expect(page).to have_content("Price: $#{@inv_itm1.unit_price / 100.0}")
      expect(page).to have_content(@inv_itm1.status)
    end

    it 'US35 I see the total revenue that will be generated by this invoice' do
      test_data
      visit admin_invoice_path(@invoice1)
      save_and_open_page

      expect(page).to have_content("Total Revenue: #{@invoice1.total_revenue}")
    end

    it "I see that each invoice status is a select field with it's current status selected and can change status of an invoice" do
      test_data
      visit admin_invoice_path(@invoice1)

      expect(page).to have_selector(".invoice_info", text: @invoice1.status)
      select('completed', from: 'Status')

      expect(page).to have_button("Update Invoice Status")
      click_button("Update Invoice Status")

      expect(current_path).to eq(admin_invoice_path(@invoice1))
      expect(page).to have_selector(".invoice_info", text: 'in progress')

      select('completed', from: 'Status')
      click_button("Update Invoice Status")

      expect(current_path).to eq(admin_invoice_path(@invoice1))
      expect(page).to have_selector(".invoice_info", text: 'completed')
    end
  end
end

