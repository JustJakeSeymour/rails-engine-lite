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
    begin 
      merchant_check if item_params[:merchant_id].present?
      Item.update(params[:id], item_params)
      render json: ItemSerializer.new(Item.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => e
      render json: {'errors' => e.message}, status: 404
    end
  end
  
  def delete
    Item.destroy(params[:id])
    render json: ItemSerializer.new(Item.all), status: 204
  end
  
private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def merchant_check
    Merchant.find(params[:item][:merchant_id])
  end
end