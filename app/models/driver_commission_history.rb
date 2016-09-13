class DriverCommissionHistory < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'DrvrcomhKey'
  self.table_name = 'Trucking_Drivers_Commissions_History'

  belongs_to :customer, foreign_key: :CustomerId, primary_key: :CustomerId
  belongs_to :driver, foreign_key: :DriverId, primary_key: :DriverId
  belongs_to :movement_type, foreign_key: :MovementCd

  def self.default_scope
    includes(:customer, :driver, :movement_type)
      .joins(:customer, :driver, :movement_type)
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
