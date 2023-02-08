class Api::V1::Merchants::FindController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.single_search(params[:name]))
  end
end