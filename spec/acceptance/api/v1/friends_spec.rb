require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Friends' do
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  let(:auth_access_token) { auth_headers['access-token'] }
  let(:auth_token_type) { auth_headers['token-type'] }
  let(:auth_client) { auth_headers['client'] }
  let(:auth_expiry) { auth_headers['expiry'] }
  let(:auth_uid) { auth_headers['uid'] }
  header 'access_token', :auth_access_token
  header 'token-type', :auth_token_type
  header 'client', :auth_client
  header 'expiry', :auth_expiry
  header 'uid', :auth_uid

  get '/api/v1/friends' do
    before { user.friends << create(:user) }
    response_field :links, 'pagination links'
    response_field :conversations, 'array of friends'
    example_request 'list friends' do
      expect(status).to eq(200)
      expect(json_response).to be_an(Hash)
      expect(json_response['friends']).to be_an(Array)
      expect(json_response['friends'].size).to eq(1)
    end
  end

  get '/api/v1/friends/:id' do
    let(:friend) { create(:user) }
    before { user.friends << friend }
    let(:id) { friend.id }
    example_request 'get a friend' do
      expect(status).to eq(200)
      expect(json_response).to be_an(Hash)
      expect(json_response['id']).to eq(id)
      expect(json_response.keys).to eq(%w(id mobile name created_at updated_at))
    end
  end

  get '/api/v1/friends/fetch' do
    let(:friend) { attributes_for(:user) }
    parameter :mobile,
              'Friend\'s mobile number (Any non-numeric characters will automatically be stripped)',
              required: true,
              scope: :friend
    parameter :name,
              'Friend\'s name',
              required: true,
              scope: :friend
    let(:mobile) { friend[:mobile] }
    let(:name) { friend[:name] }
    example_request 'fetch for a friend' do
      expect(status).to eq(200)
      expect(json_response).to be_an(Hash)
      expect(json_response['id']).to be_an(Integer)
      expect(json_response['name']).to eq(name)
      expect(json_response['mobile']).to eq(mobile.gsub(/\D/, ''))
      expect(json_response.keys).to eq(%w(id mobile name created_at updated_at))
    end
  end
end
