require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "associations" do
    it { should belong_to(:merchant) } 
  end

  describe "class methods" do
    before :each do
      @merchant = create(:merchant)
    end

    it "name_search" do
      result_items = create_list(:item, 3, merchant_id: @merchant.id)
      result_items.each do |item|
        item.update(name: item.name + "match")
      end
      non_result_items = create_list(:item, 2, merchant_id: @merchant.id, name: "nope")

      search = "atc"

      expect(Item.name_search(search).count).to eq(3)
      expect(Item.name_search(search).include?(result_items[0])).to be true
      expect(Item.name_search(search).include?(non_result_items[0])).to be false
    end
  end
end
