require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Conversations' do
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

  get '/api/v1/conversations' do
    before { user.conversations.create }
    response_field :links, 'pagination links'
    response_field :conversations, 'array of conversations'
    example_request 'list conversations' do
      expect(status).to eq(200)
      expect(json_response).to be_an(Hash)
      expect(json_response['conversations']).to be_an(Array)
      expect(json_response['conversations'].size).to eq(1)
    end
  end

  get '/api/v1/conversations/:id' do
    let(:conversation) { user.conversations.create }
    let(:id) { conversation.id }
    example_request 'get a conversation' do
      expect(status).to eq(200)
      expect(json_response).to be_an(Hash)
      expect(json_response['id']).to eq(id)
      expect(json_response['mode']).to eq('single')
    end
  end

  post '/api/v1/conversations' do
    let(:user_ids) { [create(:user).id] }
    parameter :user_ids,
              'Array of IDs of other conversation participants',
              required: true,
              scope: :conversation
    example_request 'create a conversation' do
      explanation 'If you provide multiple user_ids the mode will be set to multiple.'\
      'You can only add user_ids who you have established a friendship with (See Friendships).'
      expect(status).to eq(201)
      expect(json_response).to be_an(Hash)
      expect(json_response['id']).to be_an(Integer)
      # expect(json_response['user_ids']).to eq(user_ids)
      # expect(params['conversation']).to eq('mode' => 'single')
    end
  end

  delete '/api/v1/conversations/:id' do
    context 'multiple' do
      let(:conversation) { user.conversations.create(mode: 'multiple') }
      let(:id) { conversation.id }
      example_request 'destroy a group conversation' do
        explanation 'You can only destroy a group conversation'
        expect(status).to eq(200)
        expect(json_response).to be_an(Hash)
        expect(json_response['id']).to be_an(Integer)
        expect(json_response['id']).to eq(id)
        expect(json_response['mode']).to eq('multiple')
      end
    end
    context 'single' do
      let(:conversation) { user.conversations.create }
      let(:id) { conversation.id }
      example 'conversation cannot be destroyed', document: false do
        conversation.single!
        do_request
        expect(status).to eq(400)
        expect(json_response).to be_an(Hash)
        expect(json_response['id']).to be_an(Integer)
        expect(json_response['id']).to eq(id)
        expect(json_response['mode']).to eq('single')
      end
    end
  end
end
