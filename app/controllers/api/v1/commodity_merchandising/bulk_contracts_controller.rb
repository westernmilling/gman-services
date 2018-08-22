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
          'and Contract.LocationId = InvPickUpOrders.ContractLocationId'
        end

        def column_names
          column_name_generator(Contract) + column_name_generator(PickUpOrder)
        end

        def column_name_generator(model_class)
          model_class.column_names.map do |name|
            "#{model_class.table_name}.#{name}"
          end
        end
      end
    end
  end
end
