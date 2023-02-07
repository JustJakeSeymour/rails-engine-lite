class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    merchant_items = Item.where(merchant_id: params[:merchant_id])
    render json: ItemSerializer.new(merchant_items)
  end
end