require 'rails_helper'

describe "Api::V1::Transactions", type: :request do
  include Rack::Test::Methods

  before do
    header 'Content-Type', 'application/json'
  end

  describe "POST /api/v1/transactions" do

    let(:credentials) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV['USER_NAME'], ENV['PASSWORD']) }

    context "with data" do
      let(:merchant) { create(:merchant) }
    
      let(:valid_params) do
        {
          uuid: '123fff',
          status: 'approved',
          merchant_id: merchant.id,
          customer_email: 'abcf@gmail.com',
          amount: 10.2
        }
      end
      
      it "should return a status code 201" do
        post "/api/v1/transactions", valid_params.to_json, { 'HTTP_AUTHORIZATION' => credentials }
        expect(last_response.status).to eq 201
      end
     
    end

    context "with inactive merchant" do
      let(:merchant) { create(:merchant, status: 'inactive') }
    
      let(:valid_params) do
        {
          uuid: '123fff',
          status: 'approved',
          merchant_id: merchant.id,
          customer_email: 'abcf@gmail.com',
          amount: 10.2
        }
      end
      
      it "should return a status code 403" do
        post "/api/v1/transactions", valid_params.to_json, { 'HTTP_AUTHORIZATION' => credentials }
        expect(last_response.status).to eq 403
      end

      it "should return a status code 201" do
        post "/api/v1/transactions", valid_params.to_json, { 'HTTP_AUTHORIZATION' => credentials }
        expect(JSON.parse(last_response.body)).to eq({"error" => "Merchant is not active"})
      end
     
    end

    context "with invalid merchant" do
    
      let(:valid_params) do
        {
          uuid: '123fff',
          status: 'approved',
          merchant_id: 14,
          customer_email: 'abcf@gmail.com',
          amount: 10.2
        }
      end
      
      it "should return a status code 403" do
        post "/api/v1/transactions", valid_params.to_json, { 'HTTP_AUTHORIZATION' => credentials }
        expect(last_response.status).to eq 404
      end

      it "should return a status code 201" do
        post "/api/v1/transactions", valid_params.to_json, { 'HTTP_AUTHORIZATION' => credentials }
        expect(JSON.parse(last_response.body)).to eq({"error" => "Merchant not found"})
      end
     
    end

    context "without data" do
      it "should return status code 500" do
        post "/api/v1/transactions", {}.to_json, { 'HTTP_AUTHORIZATION' => credentials }
        expect(last_response.status).to eq(500)
      end

      it "should return error message" do
        post "/api/v1/transactions", {}.to_json, { 'HTTP_AUTHORIZATION' => credentials }
        expect(JSON.parse(last_response.body)).to eq({"error" => "Internal server error"})
      end
    end
  end

end
