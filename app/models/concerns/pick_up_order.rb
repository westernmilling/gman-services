class PickUpOrder < ActiveRecord::Base
  # rubocop:disable Metrics/BlockLength
  module Columns
    extend ActiveSupport::Concern

    included do
      def self.column_names
        %w{
          ContractId
          ContractLocationId
          CarrierCustomerNumber
          CarrierCustomerSub
          FreightAmount
          ItemId
          LoadNumber
          Origin
          OriginState
          OriginWeightCertificate
          OriginGrossWeight
          OriginTareWeight
          OriginNetWeight
          PickupType
          PurchaseCustomerId
          ReleasePrefix
          ReleaseLoadNumber
          ShipDate
          Shipper
          SplitFg
          SplitTicketNumber
          Status
          TicketLocationId
        }
      end
    end
  end
  # rubocop:enable Metrics/BlockLength

  module Ransack
    extend ActiveSupport::Concern

    included do
      def self.ransackable_scopes(_auth_object = nil)
        [
          :contract_commodity_id_eq,
          :contract_contract_id_eq,
          :purchase_customer_id_eq,
          :release_prefix_eq,
          :release_load_number_eq,
          :release_number_eq
        ]
      end
    end
  end

  module Scopes
    extend ActiveSupport::Concern

    included do
      scope :contract_commodity_id_eq,
            ->(value) { where("Contract.CommodityId = #{value}") }
      scope :contract_contract_id_eq,
            ->(value) { where("Contract.Inv_ContractId = '#{value}'") }
      scope :purchase_customer_id_eq,
            ->(value) { where("PurchaseCustomerId = '#{value}'") }
      scope :release_prefix_eq,
            ->(value) { where("ReleasePrefix = '#{value}'") }
      scope :release_load_number_eq,
            ->(value) { where("ReleaseLoadNumber = #{value}") }
      scope :release_number_eq, (
        lambda do |value|
          prefix = value.slice(0, 10).strip
          load_number = value.slice(-4, 4)

          release_prefix_eq(prefix).release_load_number_eq(load_number)
        end
      )
    end
  end
end
