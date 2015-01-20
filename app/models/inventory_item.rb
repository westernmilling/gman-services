class InventoryItem < ActiveRecord::Base
  using(:grossman)
  after_initialize :init

  def init
    uuid = UUID.new
    self.uuid  = uuid.generate
  end
end
