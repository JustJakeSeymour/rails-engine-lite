require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "associations" do
    it { should have_many(:items) }
  end

  describe "class methods" do
    before :each do
      create_list(:merchant, 3)
    end
    it "single_search" do
      my_merchant = create(:merchant)
      search_name = my_merchant.name[2..5]
      
      expect(Merchant.single_search(search_name)).to eq(my_merchant)
    end
  end
end
