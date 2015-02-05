# DriverCommissionHistoryAdapter
class InventoryItemAdapter  < ActiveRecord::Base
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
      Octopus.using(:grossman) do
        ActiveRecord::Base.connection
      end
    end

    def connected_with_octopus?
      Octopus.using(:grossman) do
        ActiveRecord::Base.connected_with_octopus?
      end
    end

    def all
      Octopus.using(:grossman) do
        results = connection.execute(sanitized_sql(QUERY_ALL))
        results.map(&:to_snake_keys)
      end
    end

    def like_id_description(item_id, initem_description)
      Octopus.using(:grossman) do
        results = connection.execute(sanitized_sql(LIKE_ID_DESCRIPTION,
                                                   item_id,
                                                   initem_description))
        results.map(&:to_snake_keys)
      end
    end

    def by_id(item_id)
      Octopus.using(:grossman) do
        results = connection.execute(sanitized_sql(BY_ID, item_id))
        results.map(&:to_snake_keys)
      end
    end

    def sanitized_sql(query, *options)
      Octopus.using(:grossman) do
        ActiveRecord::Base.send(:sanitize_sql_array, [query, *options])
      end
    end

    def not_supported
      fail 'Not supported!'
    end
    alias :new :not_supported
    alias :delete :not_supported
    alias :destroy :not_supported
  end
end
