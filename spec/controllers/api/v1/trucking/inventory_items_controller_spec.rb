require 'rails_helper'

RSpec.describe Api::V1::Inventory::ItemsController, :type => :controller do
  before do
    allow(controller).to receive(:doorkeeper_token).and_return(token)
  end

  let(:inventory_items) do
    [
      {
        :item_id => Faker::Number.number(4),
        :in_item_description => Faker::Name.first_name,
      },
      {
        :item_id => Faker::Number.number(4),
        :in_item_description => Faker::Company.bs,
      }
    ]
  end
  before do
    allow(InventoryItemAdapter)
      .to receive(:all) { inventory_items }
    allow(InventoryItemAdapter)
      .to receive(:like_id_description) { inventory_items }
    allow(InventoryItemAdapter)
      .to receive(:by_id) { inventory_items }
  end

  describe 'doorkeeper token' do
    context 'token accepted' do
      let(:token) { double :acceptable? => true }
      it 'responds with 200' do
        get :index, :format => :json
        expect(response.status).to eq(200)
      end
    end

    context 'token not accepted' do
      let(:token) do
        double :acceptable? => false,
               :accessible? => false
      end
      it 'responds with 401' do
        get :index, :format => :json
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'GET index' do
    let(:token) { double :acceptable? => true }

    before { index }
    subject(:index) { get :index, :format => format }
    context 'when format is json' do
      let(:format) { :json }

      it 'responds with 200' do
        expect(response.status).to eq(200)
      end
      it 'responds with json' do
        expect(response.content_type).to eq('application/json')
      end
      it 'body is not a null string' do
        expect(response.body).not_to eq('null')
      end
      it 'body is parseable JSON' do
        expect { JSON.parse(response.body) }.not_to raise_error
      end

      describe 'parsed JSON schema' do
        subject(:json) { JSON.parse(response.body, :symbolize_names => true) }

        it 'is an array' do
          is_expected.to be_kind_of(Array)
        end

        describe 'first element' do
          subject(:first_element) { json.first }

          it { is_expected.to be_kind_of(Hash) }
          its(:keys) do
            is_expected.to eq([:item_id,
                               :in_item_description])
          end
        end
      end

      describe 'response.body' do
        it 'is equal to inventory items json' do
          expect(response.body).to eq(inventory_items.to_json)
        end
      end
    end
    context 'when format is html' do
      let(:format) { :html }
      it 'responds with 406' do
        expect(response.status).to eq(406)
      end
    end
  end

  describe 'GET like_id_description' do
    let(:token) { double :acceptable? => true }

    before { like_id_description }
    subject(:like_id_description) do
      get :like_id_description,
          :format => format,
          :item_id => 1,
          :in_item_description => 'desc'
    end
    context 'when format is json' do
      let(:format) { :json }

      it 'responds with 200' do
        expect(response.status).to eq(200)
      end
      it 'responds with json' do
        expect(response.content_type).to eq('application/json')
      end
      it 'body is not a null string' do
        expect(response.body).not_to eq('null')
      end
      it 'body is parseable JSON' do
        expect { JSON.parse(response.body) }.not_to raise_error
      end

      describe 'parsed JSON schema' do
        subject(:json) { JSON.parse(response.body, :symbolize_names => true) }

        it 'is an array' do
          is_expected.to be_kind_of(Array)
        end

        describe 'first element' do
          subject(:first_element) { json.first }

          it { is_expected.to be_kind_of(Hash) }
          its(:keys) do
            is_expected.to eq([:item_id,
                               :in_item_description])
          end
        end
      end

      describe 'response.body' do
        it 'is equal to inventory items json' do
          expect(response.body).to eq(inventory_items.to_json)
        end
      end
    end
    context 'when format is html' do
      let(:format) { :html }
      it 'responds with 406' do
        expect(response.status).to eq(406)
      end
    end
  end
  describe 'GET by_id' do
    let(:token) { double :acceptable? => true }

    before { by_id }
    subject(:by_id) do
      get :by_id,
          :format => format,
          :item_id => 1
    end
    context 'when format is json' do
      let(:format) { :json }

      it 'responds with 200' do
        expect(response.status).to eq(200)
      end
      it 'responds with json' do
        expect(response.content_type).to eq('application/json')
      end
      it 'body is not a null string' do
        expect(response.body).not_to eq('null')
      end
      it 'body is parseable JSON' do
        expect { JSON.parse(response.body) }.not_to raise_error
      end

      describe 'parsed JSON schema' do
        let(:json) { JSON.parse(response.body, :symbolize_names => true) }

        it 'is an array' do
          expect(json).to be_kind_of(Array)
        end

        describe 'first element' do
          subject(:first_element) { json.first }

          it { is_expected.to be_kind_of(Hash) }
          its(:keys) do
            is_expected.to eq([:item_id,
                               :in_item_description])
          end
        end
      end

      describe 'response.body' do
        it 'is equal to inventory items json' do
          expect(response.body).to eq(inventory_items.to_json)
        end
      end
    end
    context 'when format is html' do
      let(:format) { :html }
      it 'responds with 406' do
        expect(response.status).to eq(406)
      end
    end
  end
end
