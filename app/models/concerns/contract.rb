class Contract < ActiveRecord::Base
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
          :commodity_id_eq,
          :contract_type_eq,
          :customer_id_eq,
          :inv_contract_id_eq,
          :location_id_eq
        ]
      end
    end
  end

  module Scopes
    extend ActiveSupport::Concern

    included do
      scope :commodity_id_eq,
            ->(value) { where("Contract.CommodityId = #{value}") }
      scope :contract_type_eq,
            ->(value) { where("Contract.CONT_ContractType = '#{value}'") }
      scope :customer_id_eq,
            ->(value) { where("Contract.CustomerId = '#{value}'") }
      scope :inv_contract_id_eq,
            ->(value) { where("Contract.Inv_ContractId = #{value}") }
      scope :location_id_eq,
            ->(value) { where("Contract.LocationId = #{value}") }
    end
  end
end
