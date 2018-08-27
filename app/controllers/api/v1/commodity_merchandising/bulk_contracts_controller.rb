module Api
  module V1
    module CommodityMerchandising
      class BulkContractsController < Api::BaseController
        def index
          render text: resources, status: :ok
        end

        private

        def resources
          JSON.dump(records)
        end

        def records
          Contract.connection.select(search_query_string).to_a
        end

        def search_query_string
          "select #{column_names.join(', ')} from Contract " \
          'INNER JOIN InvPickUpOrders on ' \
          'InvPickUpOrders.ContractId = Contract.Inv_ContractId ' \
          'INNER JOIN Commodity on ' \
          'Commodity.CommodityId = Contract.CommodityId ' \
          'and Contract.LocationId = InvPickUpOrders.ContractLocationId'
        end
        # Worked with commodity id. Took 1:17

        def column_names
          contract_column_names +
            pick_up_order_column_names +
            commodity_column_names
        end

        def commodity_column_names
          column_name_generator(Commodity, ['COMM_ConversionFactor'])
        end

        def contract_column_names
          columns = %w(
            CustomerId
            CONT_ContractDate
            CONT_ContractType
            CONT_FobLocationDescription1
            CONT_Price
            CONT_Quantity
            CONT_FromDate
            CONT_ToDate
          )
          column_name_generator(Contract, columns)
        end

        def pick_up_order_column_names
          columns = %w(
            ContractId
            ItemId
            Origin
            OriginState
            PickupType
            ReleaseLoadNumber
            ReleasePrefix
            Status
          )
          column_name_generator(PickUpOrder, columns)
        end

        def column_name_generator(model_class, columns)
          columns.map do |name|
            [model_class.table_name, name].join('.')
          end
        end
      end
    end
  end
end
