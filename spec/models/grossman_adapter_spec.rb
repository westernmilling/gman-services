require 'rails_helper'

RSpec.describe GrossmanAdapter, :type => :model do
  let(:gman_adapter) { GrossmanAdapter }

  describe '#not_supported' do
    subject { gman_adapter.not_supported }

    it { expect { subject }.to raise_error.with_message(/Not supported!/) }
  end

  describe '#new' do
    subject { gman_adapter.new }

    it { expect { subject }.to raise_error.with_message(/Not supported!/) }
  end

  describe '#delete' do
    subject { gman_adapter.delete }

    it { expect { subject }.to raise_error.with_message(/Not supported!/) }
  end

  describe '#destroy' do
    subject { gman_adapter.destroy }

    it { expect { subject }.to raise_error.with_message(/Not supported!/) }
  end

  describe '#gman_connection' do
    subject { gman_adapter.gman_connection }

    its(:current_shard) { is_expected.to eq(:grossman) }
  end

  describe '#connected_with_octopus?' do
    subject { gman_adapter.gman_connected_with_octopus? }

    it { is_expected.to be_truthy }
  end
end
