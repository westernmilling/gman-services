module Api
  module V1
    module Inventory
      # Inventory Api endpoint
      class ItemsController < ApplicationController
        before_action :doorkeeper_authorize!
        # skip_before_filter :verify_authenticity_token

        # GET /inventory_items.json
        def index
          respond_to do |format|
            format.json { render :json => InventoryItemAdapter.all }
          end
        end

        # GET /inventory_items_like_id_description.json
        def like_id_description
          respond_to do |format|
            format.json do
              render :json => InventoryItemAdapter
                .like_id_description(params['item_id'],
                                     params['in_item_description'])
            end
          end
        end
        # GET /inventory_items_by_id.json
        def by_id
          respond_to do |format|
            format.json do
              render :json => InventoryItemAdapter.by_id(params['item_id'])
            end
          end
        end
      end
    end
  end
end
