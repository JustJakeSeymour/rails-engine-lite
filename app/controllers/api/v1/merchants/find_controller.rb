class Api::V1::Merchants::FindController < ApplicationController
  def index
    if params[:name]
      render json: MerchantSerializer.new(Merchant.single_search(params[:name]))
    else
      
    end
  end
end