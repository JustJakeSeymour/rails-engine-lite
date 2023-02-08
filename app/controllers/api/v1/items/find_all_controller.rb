class Api::V1::Items::FindAllController < ApplicationController
  def index
    params_check(params)
    render json: ItemSerializer.new(Item.find_all_by_name_or_price(params))
  end

private
  def params_check(params)
    if (params[:name] && params[:min_price]) || (params[:name] && params[:max_price])
      p "some sad path message needed"
    end
  end
end