class Contract < ActiveRecord::Base
  # rubocop:disable Metrics/BlockLength
  module Columns
    extend ActiveSupport::Concern

    included do
      def self.column_names
        %w{
          CustomerId
          CommodityId
          ContractId
          CommUOMId
          LocationId
          CONT_ContractDate
          CONT_ContractNumber
          CONT_ContractSub
          CONT_ContractType
          CONT_DeliveredBushels
          CONT_FreightAdjustment
          CONT_Price
          CONT_Quantity
          CONT_FromDate
          CONT_ToDate
          Inv_ContractId
        }
      end
    end
  end

  module Ransack
    extend ActiveSupport::Concern

    included do
      def self.ransackable_scopes(_auth_object = nil)
        [
          :balance_eq,
          :balance_not_eq,
          :commodity_id_eq,
          :contract_type_eq,
          :customer_id_eq,
          :inv_contract_id_eq,
          :inv_contract_id_in,
          :location_id_eq
        ]
      end
    end
  end

  module Scopes
    extend ActiveSupport::Concern

    BALANCE_CALC = '(Contract.CONT_Quantity - Contract.CONT_DeliveredBushels)'
                   .freeze

    included do
      class << self
        def balance_eq(value)
          where(format('%s = %d', BALANCE_CALC, value))
        end

        def balance_not_eq(value)
          where(format('%s <> %d', BALANCE_CALC, value))
        end

        def commodity_id_eq(value)
          where("Contract.CommodityId = #{value}")
        end

        def contract_type_eq(value)
          where('Contract.CONT_ContractType = ?', value)
        end

        def customer_id_eq(value)
          where('Contract.CustomerId = ?', value)
        end

        def inv_contract_id_eq(value)
          where('Contract.Inv_ContractId = ?', value)
        end

        def inv_contract_id_in(value)
          values_string = value
                          .split(',')
                          .map { |contract_id| "'#{contract_id}'" }
                          .join(', ')

          where("Contract.Inv_ContractId IN (#{values_string})")
        end

        def location_id_eq(value)
          where("Contract.LocationId = #{value}")
        end
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
