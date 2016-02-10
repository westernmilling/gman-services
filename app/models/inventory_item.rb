class InventoryItem < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'ItemId'
  self.table_name = 'InvItems'

  def self.default_scope
    select(column_names.map(&:to_s))
  end

  def self.column_names
    %w{
      ItemId
      InItem_Description
    }
  end
end
