# DriverCommissionHistoryAdapter
class InventoryItemAdapter
  # self.using(:grossman).connection.current_shard
  QUERY_ALL = <<SQL
          SELECT
          ItemId
        , InItem_Description
        FROM
          InvItems
SQL

  LIKE_ID_DESCRIPTION = <<SQL
        SELECT
          ItemId
        , InItem_Description
        FROM
          InvItems
        WHERE
          ItemId LIKE ? AND
          InItem_Description LIKE ?
SQL

  BY_ID = <<SQL
        SELECT
          ItemId
        , InItem_Description
        FROM
          InvItems
        WHERE
          ItemId = ?
SQL

  class << self
    def connection
      ActiveRecord::Base.using(:grossman).connection
    end

    def connected_with_octopus?
      ActiveRecord::Base.using(:grossman).connected_with_octopus?
    end

    def all
      results = connection.execute(sanitized_sql(QUERY_ALL))
      results.map(&:to_snake_keys)
    end

    def like_id_description(item_id, initem_description)
      results = connection.execute(sanitized_sql(LIKE_ID_DESCRIPTION,
                                                 item_id,
                                                 initem_description))
      results.map(&:to_snake_keys)
    end

    def by_id(item_id)
      results = connection.execute(sanitized_sql(BY_ID, item_id))
      results.map(&:to_snake_keys)
    end

    def sanitized_sql(query, *options)
      ActiveRecord::Base.send(:sanitize_sql_array, [query, *options])
    end
  end
end
