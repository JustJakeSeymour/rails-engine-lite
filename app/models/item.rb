class Item < ApplicationRecord
  belongs_to :merchant

  def self.name_search(search)
    self.where("name ILIKE ?", "%#{search}%")
  end
end
