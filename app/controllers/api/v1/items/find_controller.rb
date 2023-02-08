class Api::V1::Items::FindController < ApplicationController
  def index
    require 'pry'; binding.pry
    # pass params[:min] && params[:max] to use conditions in helper method
  end
end