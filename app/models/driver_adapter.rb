# DriverAdapter
class DriverAdapter
  # self.using(:grossman).connection.current_shard

  class << self
    def connection
      ActiveRecord::Base.using(:grossman).connection
    end

    def connected_with_octopus?
      ActiveRecord::Base.using(:grossman).connected_with_octopus?
    end

    def drivers
      [
        {
          :driver_id => 0001,
          :first_name => 'test', :last_name => 'test',
          :driver_type => 'DR'
        }
      ]
    end
  end
end
