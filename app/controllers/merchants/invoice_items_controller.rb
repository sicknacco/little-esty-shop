class Merchants::InvoiceItemsController < ApplicationController
  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(invoice_item_params)
    redirect_to merchant_invoice_path(params[:merchant_id], invoice_item.invoice_id)
  end

  def invoice_item_params
    params.require(:invoice_item).permit(:status)
  end

end