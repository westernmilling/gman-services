module Api
  module V1
    module CommodityMerchandising
      class BulkContractsController < Api::BaseController
        def index
          render json: resources, status: :ok
        end

        private

        def resources
          @_resources ||= search.as_json(include: :pick_up_orders)
        end

        def search
          Contract.connection.select(search_query_string).to_a
        end

        def search_query_string
          "select #{column_names.join(', ')} from Contract " \
          'INNER JOIN InvPickUpOrders on ' \
          'InvPickUpOrders.ContractId = Contract.Inv_ContractId ' \
          'and Contract.LocationId = InvPickUpOrders.ContractLocationId ' \
          "where CustomerId IN (#{customer_ids})"
        end

        def column_names
          column_name_generator(Contract) + column_name_generator(PickUpOrder)
        end

        def column_name_generator(model_class)
          model_class.column_names.map do |name|
            "#{model_class.table_name}.#{name}"
          end
        end

        def customer_ids
          params[:customer_ids].split(',').map do |customer_id|
            "'#{customer_id}'"
          end.join(',')
        end
      end
    end
  end
end
