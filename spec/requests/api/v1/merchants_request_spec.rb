require 'rails_helper'

describe "Merchants API" do
  describe "Section One RESTFUL endpoints" do
    it "sends a list of all merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful 
      
      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to have_key(:data)
      expect(merchants[:data]).to be_an(Array)
      
      
      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)
        
        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)
        expect(merchant[:type]).to eq("merchant")
        
        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)
        
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
        
        expect(merchant[:attributes]).to_not have_key(:created_at)
        expect(merchant[:attributes]).to_not have_key(:updated_at)
      end
    end
    
    it "sends a single merchant" do
      id = create(:merchant).id
      
      get "/api/v1/merchants/#{id}"
      
      expect(response).to be_successful 
      
      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_a(Hash)
      
      merchant_data = merchant[:data]
      
      expect(merchant_data).to have_key(:id)
      expect(merchant_data[:id]).to be_an(String)
      
      expect(merchant_data).to have_key(:type)
      expect(merchant_data[:type]).to be_a(String)
      expect(merchant_data[:type]).to eq("merchant")
      
      expect(merchant_data).to have_key(:attributes)
      expect(merchant_data[:attributes]).to be_a(Hash)

      expect(merchant_data[:attributes]).to have_key(:name)
      expect(merchant_data[:attributes][:name]).to be_a(String)
      
      expect(merchant_data[:attributes]).to_not have_key(:created_at)
      expect(merchant_data[:attributes]).to_not have_key(:updated_at)
    end
    
    it "sends all items related to a merchant ID" do
      merchant = create(:merchant)
      other_merchant = create(:merchant)
      
      items = create_list(:item, 3, merchant_id: merchant.id)  
      other_item = create(:item, merchant_id: other_merchant.id)
      
      get "/api/v1/merchants/#{merchant.id}/items"
      
      expect(response).to be_successful 
      
      merchant_items = JSON.parse(response.body, symbolize_names: true)
      
      expect(merchant_items).to have_key(:data)
      expect(merchant_items[:data]).to be_an(Array)
      expect(merchant_items[:data].count).to eq(3)
      
      merchant_items[:data].each do |merchant_item| 
        expect(merchant_item).to have_key(:id)
        expect(merchant_item[:id]).to be_an(String)
        
        
        expect(merchant_item).to have_key(:type)
        expect(merchant_item[:type]).to be_a(String)
        expect(merchant_item[:type]).to eq("item")
        
        expect(merchant_item).to have_key(:attributes)
        expect(merchant_item[:attributes]).to be_a(Hash)
        
        expect(merchant_item[:attributes]).to have_key(:name)
        expect(merchant_item[:attributes][:name]).to be_a(String)
        
        expect(merchant_item[:attributes]).to have_key(:description)
        expect(merchant_item[:attributes][:description]).to be_a(String)
        
        expect(merchant_item[:attributes]).to have_key(:unit_price)
        expect(merchant_item[:attributes][:unit_price]).to be_a(Float)
        
        expect(merchant_item[:attributes]).to have_key(:merchant_id)
        expect(merchant_item[:attributes][:merchant_id]).to be_an(Integer)
        expect(merchant_item[:attributes][:merchant_id]).to eq(merchant.id)
        expect(merchant_item[:attributes][:merchant_id]).to_not eq(other_merchant.id)
        
        expect(merchant_item[:attributes]).to_not have_key(:created_at)
        expect(merchant_item[:attributes]).to_not have_key(:updated_at)
      end
    end
  end
  
  describe "Section Two Non-RESTFUL endpoints" do
    it "either returns a single merchant via search" do
      my_merchant = create(:merchant)
      other_merchant = create(:merchant)
      
      get "/api/v1/merchants/find?name=#{my_merchant.name[0..3]}"
      
      expect(response).to be_successful 
      
      merchant = JSON.parse(response.body, symbolize_names: true)
      
      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_a(Hash)
      
      merchant_data = merchant[:data]
      
      expect(merchant_data).to have_key(:id)
      expect(merchant_data[:id]).to be_an(String)
      expect(merchant_data[:id].to_i).to eq(my_merchant.id)
      expect(merchant_data[:id].to_i).to_not eq(other_merchant.id)
      
      expect(merchant_data).to have_key(:type)
      expect(merchant_data[:type]).to be_a(String)
      expect(merchant_data[:type]).to eq("merchant")
      
      expect(merchant_data).to have_key(:attributes)
      expect(merchant_data[:attributes]).to be_a(Hash)
      
      expect(merchant_data[:attributes]).to have_key(:name)
      expect(merchant_data[:attributes][:name]).to be_a(String)
      expect(merchant_data[:attributes][:name]).to eq(my_merchant.name)
      expect(merchant_data[:attributes][:name]).to_not eq(other_merchant.name)
      
      expect(merchant_data[:attributes]).to_not have_key(:created_at)
      expect(merchant_data[:attributes]).to_not have_key(:updated_at)
    end
  end
  
  describe "sad path error" do
    context "error" do
      it "rescues standard error if bad ID" do
        
        get "/api/v1/merchants/0/items"
        
        expect(response.body).to eq("status: 400")         
      end
    end
  end
end