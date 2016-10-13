require 'rails_helper'

RSpec.describe OrderQuery, type: :model do
  subject do
    OrderQuery.new(
      warehouse_id_eq: warehouse_id_eq,
      order_number_eq: order_number_eq
    ).to_ransack_query
  end

  describe '#to_ransack_query' do
    let(:warehouse_id_eq) { '12' }
    let(:order_number_eq) { '123456' }

    context 'when warehouse_id_eq and order_number_eq are present' do
      it do
        is_expected.to eq(
          warehouse_id_eq: warehouse_id_eq,
          order_number_eq: order_number_eq
        )
      end
    end

    context 'when warehouse_id_eq is missing' do
      let(:warehouse_id_eq) { '' }

      it do
        expect { subject }.to raise_error(ActiveModel::StrictValidationFailed)
      end
    end

    context 'when warehouse_id_eq is 3 characters long' do
      let(:warehouse_id_eq) { '123' }

      it do
        expect { subject }.to raise_error(ActiveModel::StrictValidationFailed)
      end
    end

    context 'when order_number_eq is missing' do
      let(:order_number_eq) { '' }

      it do
        expect { subject }.to raise_error(ActiveModel::StrictValidationFailed)
      end
    end

    context 'when warehouse_id_eq is 3 characters long' do
      let(:order_number_eq) { '123' }

      it do
        expect { subject }.to raise_error(ActiveModel::StrictValidationFailed)
      end
    end
  end
end
