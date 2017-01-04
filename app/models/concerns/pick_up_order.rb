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

  module Ransack
    extend ActiveSupport::Concern

    included do
      def self.ransackable_scopes(_auth_object = nil)
        [
          :contract_balance_eq,
          :contract_balance_not_eq,
          :contract_id_eq,
          :contract_present,
          :item_commodity_id_eq,
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
        def contract_balance_eq(value)
          joins(:contract)
            .where(format('%s = %d', Contract::Scopes::BALANCE_CALC, value))
        end

        def contract_balance_not_eq(value)
          joins(:contract)
            .where(format('%s <> %d', Contract::Scopes::BALANCE_CALC, value))
        end

        def contract_id_eq(value)
          where('InvPickUpOrders.ContractId = ?', value)
        end

        def contract_present(value)
          joins(:contract)
            .where("Contract.ContractId IS #{value ? 'NOT' : ''} NULL")
        end

        def item_commodity_id_eq(value)
          where("InvItems.InItem_CommodityId = #{value}")
        end

        def purchase_customer_id_eq(value)
          where('PurchaseCustomerId = ?', value)
        end

        def release_prefix_eq(value)
          where('ReleasePrefix = ?', value)
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
  # rubocop:enable Metrics/BlockLength
end
