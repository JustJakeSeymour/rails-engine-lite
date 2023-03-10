require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "associations" do
    it { should belong_to(:merchant) } 
  end

  describe "class methods" do
    before :each do
      @merchant = create(:merchant)
    end

    describe "find_all_by_name_or_price" do
      context "params check" do
        it "returns nil if params for :name and a price are supplied" do
          params = { name: "example", min_price: 40 }

          expect(Item.find_all_by_name_or_price(params)).to eq nil
        end
      end
      
      describe "name_search" do
        it "find all by name" do
          result_items = create_list(:item, 3, merchant_id: @merchant.id)
          result_items.each do |item|
            item.update(name: item.name + "match")
          end
          non_result_items = create_list(:item, 2, merchant_id: @merchant.id, name: "nope")

          params = {name: "atc"}

          expect(Item.find_all_by_name_or_price(params).count).to eq(3)
          expect(Item.find_all_by_name_or_price(params).include?(result_items[0])).to be true
          expect(Item.find_all_by_name_or_price(params).include?(non_result_items[0])).to be false
        end
      end
      
      describe "price_search" do
        before :each do
          @cheap_items = create_list(:item, 3, merchant_id: @merchant.id, unit_price: 25.0)
          @medium_items = create_list(:item, 2, merchant_id: @merchant.id, unit_price: 50.0)
          @expensive_items = create_list(:item, 2, merchant_id: @merchant.id, unit_price: 75.0)
        end
        
        it "find all by min price" do
          params = { min_price: 50 }

          expect(Item.find_all_by_name_or_price(params).count).to eq(4)

          expect(Item.find_all_by_name_or_price(params).include?(@medium_items[0])).to be true
          expect(Item.find_all_by_name_or_price(params).include?(@expensive_items[0])).to be true
          
          expect(Item.find_all_by_name_or_price(params).include?(@cheap_items[0])).to be false
        end
        
        it "find all by max price" do
          params = { max_price: 50 }
          
          expect(Item.find_all_by_name_or_price(params).count).to eq(5)
          
          expect(Item.find_all_by_name_or_price(params).include?(@medium_items[0])).to be true
          expect(Item.find_all_by_name_or_price(params).include?(@cheap_items[0])).to be true
  
          expect(Item.find_all_by_name_or_price(params).include?(@expensive_items[0])).to be false
        end
        
        it "find all between min and max price" do
          params = { min_price: 30, max_price: 60 }
          expect(Item.find_all_by_name_or_price(params).count).to eq(2)
          
          expect(Item.find_all_by_name_or_price(params).include?(@medium_items[0])).to be true

          expect(Item.find_all_by_name_or_price(params).include?(@cheap_items[0])).to be false
          expect(Item.find_all_by_name_or_price(params).include?(@expensive_items[0])).to be false
        end
      end
    end
  end
end
