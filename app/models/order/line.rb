class Order
  class Line < ActiveRecord::Base
    establish_connection "grossman_#{Rails.env}".to_sym

    self.primary_key = 'OrderKey'
    self.table_name = 'InvCustomerOrders_Open_Detail'

    def contract
      return nil if self.ContractId == '00000000'

      @contract ||= Contract
        .where(CONT_ContractType: 'S', Inv_ContractId: self.ContractId)
        .to_a
        .first
    end

    def self.default_scope
      select(column_names.map(&:to_s))
    end

    def self.column_names
      %w{
        ItemId
        InOrd_QtyShipped
        InOrd_TotalPrice
        ContractId
      }
    end
  end
end
