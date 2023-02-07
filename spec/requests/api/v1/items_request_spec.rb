require 'rails_helper'

describe "Items API" do
  before :each do
    @merchant = create(:merchant)
  end
  describe "Section One RESTful endpoints" do
    it "sends a list of all items" do
      create_list(:item, 3, merchant_id: @merchant.id)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)
      
      expect(items).to have_key(:data)
      expect(items[:data]).to be_an(Array)
      
      items[:data].each do |item| 
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)
        
        
        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)
        expect(item[:type]).to eq("item")
        
        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)
        
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
        
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)
        
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        
        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end
    
    it "sends a single item" do
      id = create(:item, merchant_id: @merchant.id).id
      
      get "/api/v1/items/#{id}"
      
      item = JSON.parse(response.body, symbolize_names: true)
      
      expect(item).to have_key(:data)
      expect(item[:data]).to be_a(Hash)

      item_data = item[:data]

      expect(item_data).to have_key(:id)
      expect(item_data[:id]).to be_an(String)
      
      
      expect(item_data).to have_key(:type)
      expect(item_data[:type]).to be_a(String)
      expect(item_data[:type]).to eq("item")
      
      expect(item_data).to have_key(:attributes)
      expect(item_data[:attributes]).to be_a(Hash)
  
      expect(item_data[:attributes]).to have_key(:name)
      expect(item_data[:attributes][:name]).to be_a(String)
  
      expect(item_data[:attributes]).to have_key(:description)
      expect(item_data[:attributes][:description]).to be_a(String)
  
      expect(item_data[:attributes]).to have_key(:unit_price)
      expect(item_data[:attributes][:unit_price]).to be_a(Float)
      
      expect(item_data[:attributes]).to have_key(:merchant_id)
      expect(item_data[:attributes][:merchant_id]).to be_an(Integer)
    end

    it "creates and item"

    it "edits an item"

    it "deletes an item"

    it "merchant information given item ID"
  end

  describe "Section Two Non-RESTful endpoints" do
    it "return one item via search OR all items via search"

    it "search via min / max price"
  end
end