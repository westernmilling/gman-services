class Customer < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'CustomerId'
  self.table_name = 'Customers'

  def self.column_names
    %w{
      CustomerId
      Name
    }
  end
end
