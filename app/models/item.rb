class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_all_by_name_or_price(params)
    if (params[:name] && params[:min_price]) || (params[:name] && params[:max_price])
      return 
    elsif params[:name]
      name_search(params[:name]) 
    elsif params[:min_price] || params[:max_price]
      price_search(params[:min_price], params[:max_price]) 
    end
  end

  def self.name_search(name)
      self.where("name ILIKE ?", "%#{name}%")
  end
     
  def self.price_search(min_price, max_price)
    if min_price.present? && max_price.present?
      self.where(unit_price: min_price.to_i..max_price.to_i) 
    elsif min_price.present?
      self.where(unit_price: min_price.to_i..Float::INFINITY) 
    else max_price
      self.where(unit_price: 0..max_price.to_i) 
    end
  end
end
