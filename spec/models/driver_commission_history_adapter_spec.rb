require 'rails_helper'

RSpec.describe DriverCommissionHistoryAdapter, :type => :model do
  let(:driver_commission_history_adapter) { DriverCommissionHistoryAdapter }

  describe '#new' do
    subject { driver_commission_history_adapter.new }

    it { expect { subject }.to raise_error.with_message(/Not supported!/) }
  end

  describe '#delete' do
    subject { driver_commission_history_adapter.delete }

    it { expect { subject }.to raise_error.with_message(/Not supported!/) }
  end

  describe '#destroy' do
    subject { driver_commission_history_adapter.delete }

    it { expect { subject }.to raise_error.with_message(/Not supported!/) }
  end

  describe '#connected_with_octopus?' do
    subject { driver_commission_history_adapter.connected_with_octopus? }

    it { is_expected.to be_truthy }
  end

  describe '#connection' do
    subject do
      Octopus.using(:grossman) do
        driver_commission_history_adapter.connection.current_shard
      end
    end

    it 'current_shard is equal to grossman' do
      expect(is_expected.to eq(:grossman))
    end
  end

  describe '#all' do
    before do
      Octopus.using(:grossman) do
        create(:driver_commission_history)
      end
    end

    subject(:driver_commissions) { driver_commission_history_adapter.all }

    it 'empty is not false' do
      expect(driver_commissions.empty?).to be_falsey
    end
    describe 'first driver' do
      subject { driver_commissions.first }

      it { is_expected.to have_key(:driver_id) }
      it { is_expected.to have_key(:backhauls) }
      it { is_expected.to have_key(:freight_revenue) }
      it { is_expected.to have_key(:customer_id) }
      it { is_expected.to have_key(:delivery_date) }
      it { is_expected.to have_key(:driver_rate) }
      it { is_expected.to have_key(:freight_bill_number) }
      it { is_expected.to have_key(:fuel_surcharge) }
      it { is_expected.to have_key(:layover) }
      it { is_expected.to have_key(:movement_type) }
      it { is_expected.to have_key(:other_hour_dollars) }
      it { is_expected.to have_key(:order_number_text) }
      it { is_expected.to have_key(:origin_name) }
      it { is_expected.to have_key(:paid_date) }
      it { is_expected.to have_key(:revenue) }
      it { is_expected.to have_key(:split_rate) }
      it { is_expected.to have_key(:total_freight_revenue) }
    end
  end
  describe '#by_paid_date' do
    before do
      Octopus.using(:grossman) do
        create(:driver_commission_history, :paid_date => Date.new(2014, 01, 01))
      end
    end

    subject(:driver_commissions) do
      driver_commission_history_adapter.by_paid_date(Date.new(2014, 01, 01))
    end
    it 'empty is not false' do
      expect(driver_commissions.empty?).to be_falsey
    end
    describe 'first driver' do
      subject { driver_commissions.first }

      it { is_expected.to have_key(:driver_id) }
      it { is_expected.to have_key(:backhauls) }
      it { is_expected.to have_key(:freight_revenue) }
      it { is_expected.to have_key(:customer_id) }
      it { is_expected.to have_key(:delivery_date) }
      it { is_expected.to have_key(:driver_rate) }
      it { is_expected.to have_key(:freight_bill_number) }
      it { is_expected.to have_key(:fuel_surcharge) }
      it { is_expected.to have_key(:layover) }
      it { is_expected.to have_key(:movement_type) }
      it { is_expected.to have_key(:other_hour_dollars) }
      it { is_expected.to have_key(:order_number_text) }
      it { is_expected.to have_key(:origin_name) }
      it { is_expected.to have_key(:paid_date) }
      it { is_expected.to have_key(:revenue) }
      it { is_expected.to have_key(:split_rate) }
      it { is_expected.to have_key(:total_freight_revenue) }
    end
  end
end
