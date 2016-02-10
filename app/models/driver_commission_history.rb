class DriverCommissionHistory < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'DrvrcomhKey'
  self.table_name = 'Trucking_Drivers_Commissions_History'

  # NB: belongs_to works when included, but on large result sets it fails
  #     when querying customers
  # belongs_to :customer, foreign_key: :CustomerId
  belongs_to :movement_type, foreign_key: :MovementCd

  # This is going to be tremendously inefficient, but outside of a "view" we
  # don't have much choice.
  def customer
    Customer.where(CustomerId: self.CustomerId)[0]
  end

  def self.default_scope
    select(column_names.map(&:to_s))
      .includes(:movement_type)
  end

  def self.column_names
    %w{
      CustomerId
      MovementCd
      DriverId
      Backhauls
      FreightRevenue
      DeliveryDate
      DriverRate
      FreightBillNumber
      FuelSurcharge
      Layover
      OtherHourDollars
      OrderNumberText
      OriginName
      PaidDate
      Revenue
      SplitRate
      TotalFreightRevenue
      DrvrcomhKey
    }
  end
end
