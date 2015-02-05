# DriverCommissionHistoryAdapter
class InventoryItemAdapter  < GrossmanAdapter
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
    def all
      results = gman_connection.execute(sanitized_sql(QUERY_ALL))
      results.map(&:to_snake_keys)
    end

    def like_id_description(item_id, initem_description)
      results = gman_connection.execute(sanitized_sql(LIKE_ID_DESCRIPTION,
                                                      item_id,
                                                      initem_description))
      results.map(&:to_snake_keys)
    end

    def by_id(item_id)
      results = gman_connection.execute(sanitized_sql(BY_ID, item_id))
      results.map(&:to_snake_keys)
    end

    def sanitized_sql(query, *options)
      ActiveRecord::Base.send(:sanitize_sql_array, [query, *options])
    end
  end
end
