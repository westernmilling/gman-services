require 'rails_helper'

RSpec.describe '/api/v1/inventory/items', :type => :request do
  let(:application) { create(:doorkeeper_application)  }
  subject(:response) { oauth_get(url, application.uid, application.secret) }
  describe 'all' do
    let(:all) do
      InventoryItemAdapter.all
    end

    let(:url) { '/api/v1/inventory/items' }

    context 'when application id and secret are valid' do
      it 'response should have status equal to 200' do
        expect(response.status).to eq(200)
      end
      it 'response should have body equal to all drivers json' do
        expect(response.body).to eq(all.to_json)
      end
    end

    context 'when application id and secret are not valid' do
      subject(:response) do
        oauth_get(url, '1', '1')
      end

      it 'response should have status equal to 401' do
        expect(response.status).to eq(401)
      end

      it 'response should have blank body' do
        expect(response.body).to be_blank
      end
    end

    context 'when application id and secret are not present' do
      subject(:response) do
        get(url)
      end

      it 'response should have status equal to 401' do
        expect(response).to eq(401)
      end
    end

    describe 'like_id_description' do
      let(:like_id_description) do
        InventoryItemAdapter.like_id_description(1, ' ')
      end

      # rubocop:disable Metrics/LineLength,
      let(:url) { '/api/v1/inventory/items_like_id_description.json?item_id=1&in_item_description=des' }
      # rubocop:enable Metrics/LineLength

      context 'when application id and secret are valid' do
        it 'response should have body equal to by_paid_date json' do
          expect(response.body).to eq(like_id_description.to_json)
        end

        it 'response should have status equal to 200' do
          expect(response.status).to eq(200)
        end
      end

      context 'when application id and secret are not valid' do
        subject(:response) do
          oauth_get(url, '1', '1')
        end

        it 'response should have status equal to 401' do
          expect(response.status).to eq(401)
        end

        it 'response should have blank body' do
          expect(response.body).to be_blank
        end
      end

      context 'when application id and secret are not present' do
        subject(:response) do
          get(url)
        end

        it 'response should have status equal to 401' do
          expect(response).to eq(401)
        end
      end
    end

    describe 'by_id' do
      let(:by_id) do
        InventoryItemAdapter.by_id(1)
      end

      let(:url) { '/api/v1/inventory/items_by_id.json?item_id=1' }

      context 'when application id and secret are valid' do
        it 'response should have body equal to by_paid_date json' do
          expect(response.body).to eq(by_id.to_json)
        end

        it 'response should have status equal to 200' do
          expect(response.status).to eq(200)
        end
      end

      context 'when application id and secret are not valid' do
        subject(:response) do
          oauth_get(url, '1', '1')
        end

        it 'response should have status equal to 401' do
          expect(response.status).to eq(401)
        end

        it 'response should have blank body' do
          expect(response.body).to be_blank
        end
      end

      context 'when application id and secret are not present' do
        subject(:response) do
          get(url)
        end

        it 'response should have status equal to 401' do
          expect(response).to eq(401)
        end
      end
    end
  end
end
