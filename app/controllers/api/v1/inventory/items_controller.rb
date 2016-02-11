module Api
  module V1
    module Inventory
      # Inventory Api endpoint
      class ItemsController < ApplicationController
        before_action :doorkeeper_authorize!

        def index
          respond_to do |format|
            format.json do
              render json: InventoryItemAdapter.all
            end
          end
        end

        def like_id_description
          respond_to do |format|
            format.json do
              render json: InventoryItemAdapter
                .like_id_description(params['item_id'],
                                     params['in_item_description'])
            end
          end
        end

        def by_id
          respond_to do |format|
            format.json do
              render json: InventoryItemAdapter.by_id(params['item_id'])
            end
          end
        end
      end
    end
  end
end
