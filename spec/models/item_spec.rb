require 'rails_helper'

RSpec.describe Item, type: :model do
  define "associations" do
    it { should belong_to(:merchant) } 
  end

  define "class methods" do
    before :each do
      @merchant = create(:merchant)
    end

    it "name_search" do
      result_items = create_list(:item, 3, merchant_id: @merchant.id)
      result_items.each do |item|
        item.name = item.name + "match"
      end
      non_result_items = create_list(:item, 2, merchant_id: @merchant.id, name: "nope")

      expect(Item.name_search.count).to eq(3)
      expect(Item.name_search.include?(result_items[0], result_items[1], result_items[2])).to be true
      expect(Item.name_search.include?(non_result_items[0], non_result_items[1])).to be false
    end
  end
end
