class Api::V1::Items::FindController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.price_search(params[:min_price], params[:max_price]))
  end
end