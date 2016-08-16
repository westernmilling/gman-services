require 'rails_helper'

describe '/api/v1/orders' do
  let(:order_references) do
    create_list(:order_reference, 2)
  end
  let(:application) { create(:doorkeeper_application) }

  describe 'GET show' do
    before do
      order_references
    end
    let(:order_reference) { order_references.sample }
    let(:response) do
      oauth_get("/api/v1/orders/#{order_reference.UuidHeader}",
                application.uid,
                application.secret)
        .response
    end

    subject { response }

    it 'response should have status equal to 200' do
      expect(subject.status).to eq(200)
    end
    describe 'response body' do
      subject { JSON.parse(response.body) }

      its(['order_number']) do
        is_expected.to eq order_reference.OrderNumber
      end
      its(['order_key']) do
        is_expected.to eq order_reference.order.OrderKey
      end
      its(['quantity_shipped']) do
        is_expected.to eq order_reference.order.quantity_shipped
      end
      its(['ship_date']) do
        is_expected.to eq order_reference.ShipDate.to_s(:iso8601)
      end
      its(['warehouse_id']) do
        is_expected.to eq order_reference.WarehouseId
      end
      its(['uuid']) do
        is_expected.to eq order_reference.UuidHeader
      end
    end
  end
end
