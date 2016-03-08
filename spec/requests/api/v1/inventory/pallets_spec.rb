require 'rails_helper'

RSpec.describe '/api/v1/inventory/pallets', type: :request do
  let(:pallets) { create_list(:inventory_pallet, 2) }
  let(:application) { create(:doorkeeper_application) }
  let(:request_url) { '/api/v1/inventory/pallets' }
  subject(:response) { oauth_get(url, application.uid, application.secret) }

  context 'when application id and secret are valid' do
    let(:application) { create(:doorkeeper_application) }
    subject(:response) do
      pallets

      oauth_get(request_url,
                application.uid,
                application.secret)
    end
    it 'response should have status equal to 200' do
      expect(response.status).to eq(200)
    end
    describe 'response body' do
      let(:body) { response.body }
      subject { JSON.parse(response.body) }

      its(:size) { is_expected.to eq 2 }

      describe 'first pallet' do
        let(:first) { JSON.parse(response.body)[0] }
        subject { first }

        its(['pallet_id']) do
          is_expected.to eq pallets[0].PalletId
        end
        its(['warehouse_id']) do
          is_expected.to eq pallets[0].WarehouseId
        end
        its(['item_id']) do
          is_expected.to eq pallets[0].ItemId
        end
        its(['pallet_number']) do
          is_expected.to eq pallets[0].InPallet_PalletNo
        end
        its(['order_number']) do
          is_expected.to eq pallets[0].InPallet_OrderNo
        end
        its(['transation_date']) do
          is_expected.to eq pallets[0].InPallet_TranDate.to_s(:iso8601)
        end
        its(['transation_time']) do
          is_expected.to eq pallets[0].InPallet_TranTime.to_s(:iso8601)
        end
        its(['transaction_type_code']) do
          is_expected.to eq pallets[0].InPallet_TranTypeCd
        end
        its(['status_code']) do
          is_expected.to eq pallets[0].InPallet_StatusCd
        end
        its(['tag_type_code']) do
          is_expected.to eq pallets[0].InPallet_TagTypeCd
        end
        its(['location']) do
          is_expected.to eq pallets[0].InPallet_Location
        end
        its(['area']) do
          is_expected.to eq pallets[0].InPallet_Area
        end
        its(['sequence_number']) do
          is_expected.to eq pallets[0].InPallet_SequenceNo
        end
        its(['storage_date']) do
          is_expected.to eq pallets[0].InPallet_StorageDateCymd.to_s(:iso8601)
        end
      end
    end
  end

  context 'when application id and secret are not valid' do
    subject(:response) do
      oauth_get(request_url, '1', '1')
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
      get(request_url)
    end

    it 'response should have status equal to 401' do
      expect(response).to eq(401)
    end
  end
end
