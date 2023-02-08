class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    merchant_items = Item.find(merchant_id: params[:merchant_id])
    render json: ItemSerializer.new(merchant_items)

    rescue ActiveRecord::RecordNotFound => e
      render json: ItemSerializer.render(e.message)
  end
end