require 'rails_helper'

describe "Merchants API" do
  describe "Section One RESTFUL endpoints" do
    it "sends a list of all merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful 

      merchants = JSON.parse(response.body, symbolize_names: true)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(Integer)

        expect(merchant).to have_key(:name)
        expect(merchant[:name]).to be_a(String)
      end
    end
    
    it "sends a single merchant" do
      id = create(:merchant).id
      
      get "/api/v1/merchants/#{id}"
      
      merchant = JSON.parse(response.body, symbolize_names: true)
      
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)
  
      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_a(String)
    end

    it "sends all items related to a merchant ID"
  end

  describe "Section Two Non-RESTFUL endpoints" do
    it "either returns all merchants via search or one via search"
  end
end