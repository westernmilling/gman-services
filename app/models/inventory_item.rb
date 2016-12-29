class InventoryItem < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'ItemId'
  self.table_name = 'InvItems'

  has_one :commodity,
          foreign_key: :CommodityId,
          primary_key: :InItem_CommodityId

  def self.default_scope
    includes(:commodity).references(:commodity)
  end

  def self.column_names
    %w{
      ItemId
      InItem_Description
      InItem_CommodityId
    }
  end
end
