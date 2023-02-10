class Api::V1::Items::FindAllController < ApplicationController
  def index
    if params_check
      find_all_result = Item.find_all_by_name_or_price(params)    
      render json: ItemSerializer.new(find_all_result)
    else
      message = "Cannot search for both a name and a price."
      render status: 400
    end
  end

private
  def params_check
    true unless (params[:name].present? && params[:min_price].present?) || (params[:name].present? && params[:max_price].present?)
  end
end