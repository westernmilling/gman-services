class DriverAdapter
  class << self
    def all
      Driver
        .where(DriverType: 'DR')
        .map(&:attributes)
        .map(&:to_snake_keys)
    end
  end
end
