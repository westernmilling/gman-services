class InventoryItemAdapter
  class << self
    def all
      InventoryItem
        .all
        .map(&:attributes)
        .map(&:to_snake_keys)
    end

    def like_id_description(item_id, in_item_description)
      InventoryItem
        .where("ItemId LIKE '%#{item_id}%'")
        .where("InItem_Description LIKE '%#{in_item_description}%'")
        .map(&:attributes)
        .map(&:to_snake_keys)
    end

    def by_id(item_id)
      InventoryItem
        .where(ItemId: item_id)
        .map(&:attributes)
        .map(&:to_snake_keys)
        .first
    end
  end
end
