class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end
  
  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end
  
  def create
    new_item = Item.create!(item_params)
    render json: ItemSerializer.new(new_item), status: 201
  end
  
  def update
    Item.update(params[:id], item_params)
    render json: ItemSerializer.new(Item.find(params[:id]))
  end
  
  def delete
    Item.destroy(params[:id])
    render json: ItemSerializer.new(Item.all), status: 204
  end

private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end