class Merchant < ApplicationRecord
  has_many :items

  def self.single_search(search)
    self.where("name ILIKE ?", "%#{search}%").order(:name).first
  end
end
