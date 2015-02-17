class AddActiveToDrivers < ActiveRecord::Migration
  return if Rails.env == 'production'

  using(:grossman)
  def change
    add_column :drivers, :active_fg, :bool
    add_column :drivers, :sub_hauler_fg, :bool
  end
end
