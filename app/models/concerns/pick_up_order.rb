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
      class << self
        def contract_commodity_id_eq(value)
          where("Contract.CommodityId = #{value}")
        end

        def contract_contract_id_eq(value)
          where("Contract.Inv_ContractId = '#{value}'")
        end

        def purchase_customer_id_eq(value)
          where("PurchaseCustomerId = '#{value}'")
        end

        def release_prefix_eq(value)
          where("ReleasePrefix = '#{value}'")
        end

        def release_load_number_eq(value)
          where("ReleaseLoadNumber = #{value}")
        end

        def release_number_eq(value)
          prefix = value.slice(0, 10).strip
          load_number = value.slice(-4, 4)

          release_prefix_eq(prefix).release_load_number_eq(load_number)
        end
      end
    end
  end
end
