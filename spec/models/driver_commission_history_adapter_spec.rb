require 'rails_helper'

RSpec.describe DriverCommissionHistoryAdapter, type: :model do
  let(:driver_commission_history_adapter) { DriverCommissionHistoryAdapter }

  describe '#all' do
    before do
      create(:driver_commission_history)
    end

    subject(:driver_commissions) { driver_commission_history_adapter.all }

    it 'empty is not false' do
      expect(driver_commissions.empty?).to be_falsey
    end
    describe 'first driver' do
      subject { driver_commissions.first }
      its(:keys) do
        is_expected.to include(
          :driver_id,
          :backhauls,
          :freight_revenue,
          :customer_id,
          :delivery_date,
          :driver_rate,
          :freight_bill_number,
          :fuel_surcharge,
          :layover,
          :movement_cd,
          :other_hour_dollars,
          :order_number_text,
          :origin_name,
          :paid_date,
          :revenue,
          :split_rate,
          :total_freight_revenue,
          :drvrcomh_key
        )
      end
    end
  end
  describe '#by_paid_date' do
    before do
      create(:driver_commission_history, PaidDate: Date.new(2014, 01, 01))
    end

    subject(:driver_commissions) do
      driver_commission_history_adapter.by_paid_date(Date.new(2014, 01, 01))
    end
    it 'empty is not false' do
      expect(driver_commissions.empty?).to be_falsey
    end
    describe 'first driver' do
      subject { driver_commissions.first }

      its(:keys) do
        is_expected.to include(
          :driver_id,
          :backhauls,
          :freight_revenue,
          :customer_id,
          :delivery_date,
          :driver_rate,
          :freight_bill_number,
          :fuel_surcharge,
          :layover,
          :movement_cd,
          :other_hour_dollars,
          :order_number_text,
          :origin_name,
          :paid_date,
          :revenue,
          :split_rate,
          :total_freight_revenue,
          :drvrcomh_key
        )
      end
    end
  end
end
