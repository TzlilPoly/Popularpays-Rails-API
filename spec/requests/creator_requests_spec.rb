require 'rails_helper'

RSpec.describe 'Test Creator End Points', type: :request do
  let(:creator) { Creator.create(first_name: 'first_name', last_name: 'last_name') }

  before :all do
    ApiKey.create(key: '1234', creator_access: true, gig_access: true, gig_payment_access: true)
  end

  describe 'GET /creators' do
    before do
      # creator = Creator.create(first_name: 'first_name', last_name: 'last_name')
      get '/creators', :headers => { 'apiKey' => '1234' }
    end

    it 'returns all creators' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["data"][0]["attributes"]["first-name"]).to be_eql creator.first_name
      expect(parsed_body["data"][0]["attributes"]["last-name"]).to be_eql creator.last_name
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /creators' do
    before do
      @first_name = "first_name"
      @last_name  = "last_name"
      post '/creators', :headers => { 'apiKey' => '1234' }, params:
        { creator: {
          first_name: @first_name,
          last_name: @last_name
        } }
    end

    it 'create new creator in db' do
      creator = Creator.find_by(first_name: @first_name)
      expect(creator.first_name).to be_eql @first_name
      expect(creator.last_name).to be_eql @last_name
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(:created)
    end

  end

  describe 'GET /creators/<id>' do
    before do
      get "/creators/#{creator.id}", :headers => { 'apiKey' => '1234' }
    end

    it 'returns creator with id 1' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["data"]["id"]).to be_eql creator.id.to_s
      expect(parsed_body["data"]["attributes"]["first-name"]).to be_eql creator.first_name
      expect(parsed_body["data"]["attributes"]["last-name"]).to be_eql creator.last_name
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end