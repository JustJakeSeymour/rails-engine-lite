class Api::V1::Items::FindController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.name_search(params[:name]))
    # pass params[:min] && params[:max] to use conditions in helper method
  end
end