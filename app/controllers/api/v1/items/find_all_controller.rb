class Api::V1::Items::FindAllController < ApplicationController
  def index
    find_all_result = Item.find_all_by_name_or_price(params)    
    render json: ItemSerializer.new(find_all_result)
  end
end