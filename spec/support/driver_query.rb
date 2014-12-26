# Query helper
module Query
  def driver_query
    ActiveRecord::Base.send(:sanitize_sql_array, ['
  SELECT *
  FROM Trucking_Drivers
  '])
  end
end

RSpec.configure do |c|
  c.include Query
end
