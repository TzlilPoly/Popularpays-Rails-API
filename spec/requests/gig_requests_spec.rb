require 'rails_helper'

RSpec.describe 'Test Gig End Points', type: :request do

  let(:creator) { Creator.create(first_name: 'first_name', last_name: 'last_name') }

  before :all do
    ApiKey.create(key: '1234', creator_access: true, gig_access: true, gig_payment_access: true)
  end

  describe 'GET /gigs' do
    before do
      Gig.create(brand_name: 'brand_name', creator_id: creator.id)
      get '/gigs', :headers => { 'apiKey' => '1234' }
    end

    it 'returns all gigs' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["data"][0]["attributes"]["brand-name"]).to be_eql "brand_name"
      expect(parsed_body["data"][0]["attributes"]["state"]).to be_eql "applied"
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /gigs' do
    before do
      post '/gigs', :headers => { 'apiKey' => '1234' }, params:
        { gig: {
          brand_name: 'brand_name',
          creator_id: creator.id
        } }
    end

    it 'create new gig in db' do
      gig = Gig.find_by(brand_name: 'brand_name')
      expect(gig.brand_name).to be_eql "brand_name"
      expect(gig.creator_id).to be_eql creator.id
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(:created)
    end

  end

  describe 'GET /gigs/<id>' do
    before do
      @gig = Gig.create(brand_name: 'brand_name', creator_id: creator.id)

      get "/gigs/#{@gig.id}", :headers => { 'apiKey' => '1234' }
    end

    it 'returns gig with id 1' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["data"]["id"]).to be_eql @gig.id.to_s
      expect(parsed_body["data"]["attributes"]["brand-name"]).to be_eql @gig.brand_name
      expect(parsed_body["data"]["attributes"]["state"]).to be_eql "applied"
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /gigs/<id>' do
    before do
      @gig = Gig.create(brand_name: 'brand_name', creator_id: creator.id)

    end

    it 'update gig with id 1 state to "completed"' do
      put "/gigs/#{@gig.id}", :headers => { 'apiKey' => '1234' }, params:
        {
          gig:{
            state: "completed"
          }
        }
      gig = Gig.find_by(id: @gig.id)
      expect(gig.state).to be_eql "completed"
      expect(response).to have_http_status(:success)
    end

    it 'Change state to completed  + not existed creator and expected it dont change the state' do
      put "/gigs/#{@gig.id}", :headers => { 'apiKey' => '1234' }, params:
        {
          gig:{
            state: "completed",
            creator_id: creator.id+1
          }
        }

      gig = Gig.find_by(id: @gig.id)
      expect(gig.state).to be_eql "applied"
      expect(gig.creator_id).to be_eql creator.id
    end

  end
end