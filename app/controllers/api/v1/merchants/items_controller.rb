class Api::V1::Merchants::ItemsController < ApplicationController
  before_action :find_merchant
  
  def index
    merchant_items = Item.where(merchant_id: @merchant)
    render json: ItemSerializer.new(merchant_items)
  end

private
  def find_merchant
    begin
      @merchant = Merchant.find(params[:merchant_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: {'errors' => e.message}, status: 404
    end
  end
end