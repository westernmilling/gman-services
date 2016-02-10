class AddActiveToDrivers < ActiveRecord::Migration
  return if Driver.connection.class.to_s.include?('Relativity')

  def change
  end
end
