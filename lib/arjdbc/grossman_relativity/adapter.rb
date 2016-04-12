require 'arjdbc/relativity/adapter'

module ActiveRecord
  module ConnectionAdapters
    class GrossmanRelativityAdapter < JdbcAdapter
      def self.arel2_visitors(_config)
        require 'arel/visitors/compat'
        visitors = ::Arel::Visitors::ToSql
        { 'relativity' => visitors, 'jdbc' => visitors }
      end

      def jdbc_columns(table_name, _name = nil)
        stmt = @connection.connection.createStatement

        meta_select = meta_query(table_name)

        query_result = stmt.executeQuery(meta_select)
        metadata = query_result.getMetaData
        columns = []

        1.upto(metadata.getColumnCount) do |i|
          columns << ActiveRecord::ConnectionAdapters::Column.new(
            metadata.getColumnName(i), nil, metadata.getColumnType(i), true
          )
        end

        columns
      end

      def model(table_name)
        ar_models = ActiveRecord::Base.descendants
        model = ar_models
                .select { |klass| klass.table_name.to_s == table_name.to_s }

        return nil if model.empty?

        model.first
      end

      def meta_query(table_name)
        model = model(table_name)

        column_names = model.column_names \
          if model.singleton_methods(false).include?(:column_names)
        column_names ||= []
        statement_names = column_names
                          .join(', ')
                          .presence || '*'

        "SELECT #{statement_names} FROM #{table_name}"
      end

      alias_chained_method :columns, :query_cache, :jdbc_columns
    end
  end
end
