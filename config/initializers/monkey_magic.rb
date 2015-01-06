# puts 'Let the monkey magic begin'
# SQLite3Column
module ActiveRecord
  module ConnectionAdapters
    # SQLite3Column
    class SQLite3Column < JdbcColumn
      include ArJdbc::SQLite3::Column

      def initialize(name, *args)
        # puts "SQLite3Column: initialize: #{name}, #{args}"
        # puts *args.inspect
        if name.eql?(Hash)
          # puts "SQLite3Column: initialize: do super}"

          super
        else
          # puts "SQLite3Column: initialize: do super(nil, name, args)"

          super(nil, name, args)
        end
      end

      def self.string_to_binary(value)
        value
      end

      def self.binary_to_string(value)
        if value.respond_to?(:encoding) && value.encoding !=
                                           Encoding::ASCII_8BIT
          value = value.force_encoding(Encoding::ASCII_8BIT)
        end
        value
      end
    end
  end
end
