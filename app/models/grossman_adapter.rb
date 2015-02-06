class GrossmanAdapter < ActiveRecord::Base
  class << self
    def gman_connection
      # rubocop:disable all
      self.using(:grossman).connection
      # rubocop:enable all
    end

    def gman_connected_with_octopus?
      # rubocop:disable all
      self.using(:grossman).connected_with_octopus?
      # rubocop:enable all
    end

    def not_supported
      fail 'Not supported!'
    end
    alias :new :not_supported
    alias :delete :not_supported
    alias :destroy :not_supported
  end
end
